using Humanizer;
using ShopKey.Models;
using ShopKey.MyInterface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.DotNet.Scaffolding.Shared.Messaging;
using NuGet.Protocol.Plugins;
using System.Linq;
using ShopKey.ADO;


namespace ShopKey.Controllers
{
    public class CartController : Controller
    {
        private readonly IEmailSender _emailSender;
        public CartController(IEmailSender emailSender)
        {
            this._emailSender = emailSender;
        }
        public bool CanAccessThisAdminPage()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf = CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    if (userInf.RoleRoleId == 1 && userInf.IsActive == true)
                    {
                        var roleList = CuongNMContext.INSTANCE.Roles.ToArray();
                        ViewBag.userInf = userInf;
                        ViewBag.roleList = roleList;
                        return true;
                    }
                }
            }
            if (HttpContext.Session.Keys.Contains("userAcc"))
            {
                HttpContext.Session.Remove("userAcc");
            }
            return false;
        }

        public IActionResult Index()
        {
            bool canAccess = CanAccessThisAdminPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                var userInf = CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    var cartItemList = CuongNMContext.INSTANCE.CartItems
                        .Where(cartI => cartI.UserUsername == userInf.Username)
                        .Select(entity => new
                        {
                            ItemId = entity.ItemId,
                            Username = entity.UserUsername,
                            ProductInf = entity.ProductProduct,
                            Quantity = entity.Quantity,
                        });
                    var cartTotal = CuongNMContext.INSTANCE.Carts.Find(useAcc);
                    ViewBag.cartItemList = cartItemList;
                    ViewBag.cartTotal = cartTotal;
                    if(TempData["erokodutien"]as string != null)
                    {
                        ViewBag.Khongdutien = "Dont have Enough Money.Please add more money to Buy";
                    }
                }
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public IActionResult AddToCart(IFormCollection f)
        {
            bool canAccess = CanAccessThisAdminPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                int productId = Int32.Parse(f["productId"]);
                string oldPage = f["currentPage"];
                var cartItem =CuongNMContext.INSTANCE.CartItems
                    .Where(cartI => cartI.ProductProductId == productId && cartI.UserUsername.Equals(useAcc)).FirstOrDefault();
                if (cartItem != null)
                {
                    cartItem.Quantity += 1;
                   CuongNMContext.INSTANCE.CartItems.Update(cartItem);
                }
                else
                {
                    var productToAdd =CuongNMContext.INSTANCE.Products.Find(productId);
                    if (productToAdd != null)
                    {
                        CartItem newItemInCart = new CartItem()
                        {
                            UserUsername = useAcc,
                            ProductProductId = productToAdd.ProductId,
                            Quantity = 1,
                        };
                       CuongNMContext.INSTANCE.CartItems.Add(newItemInCart);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }

                var userCart =CuongNMContext.INSTANCE.Carts.Find(useAcc);
                if (userCart != null)
                {
                    var addingProduct =CuongNMContext.INSTANCE.Products.Find(productId);
                    userCart.Total += addingProduct.Price;
                }
               CuongNMContext.INSTANCE.SaveChanges();
                return Redirect(oldPage);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public IActionResult Delete(int Id)
        {
            bool canAccess = CanAccessThisAdminPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    var productInCartOfCustomer =CuongNMContext.INSTANCE.CartItems
                                .Where(cartI => cartI.ProductProductId == Id && cartI.UserUsername.Equals(useAcc)).FirstOrDefault();
                    if (productInCartOfCustomer != null)
                    {
                       CuongNMContext.INSTANCE.CartItems.Remove(productInCartOfCustomer);
                        var cartTotalOfCus =CuongNMContext.INSTANCE.Carts.Find(useAcc);
                        cartTotalOfCus.Total -= productInCartOfCustomer.ProductProduct.Price * productInCartOfCustomer.Quantity;
                       CuongNMContext.INSTANCE.Carts.Update(cartTotalOfCus);
                       CuongNMContext.INSTANCE.SaveChanges();
                    }
                }
                return RedirectToAction("Index", "Cart");
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public async Task<IActionResult> PlaceOrder()
        {
            bool canAccess = CanAccessThisAdminPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    var Moneytien = CuongNMContext.INSTANCE.UserBalances.Find(useAcc);
                    var cartTotalOfCu1s = CuongNMContext.INSTANCE.Carts.Find(useAcc);
                    if (Moneytien.Amount < cartTotalOfCu1s.Total)
                    {
                        TempData["erokodutien"] = "Dont have Enough Money.Please add more money to Buy";
                        return RedirectToAction("Index", "Cart");
                    }
                    else
                    {
                        var cartItemList = CuongNMContext.INSTANCE.CartItems

                            .Where(cartI => cartI.UserUsername.Equals(useAcc))
                            .Select(entity => new
                            {
                                ItemId = entity.ItemId,
                                Username = entity.UserUsername,
                                ProductInf = entity.ProductProduct,
                                Quantity = entity.Quantity,
                            });
                        if (cartItemList != null)
                        {
                            var userBal = CuongNMContext.INSTANCE.UserBalances.Find(useAcc);
                            string messageHeader = "";
                            string messageBody = "";
                            foreach (var item in cartItemList)
                            {
                                var prdKey = CuongNMContext.INSTANCE.ProductKeys
                                    .Where(prdK => prdK.ProductProductId == item.ProductInf.ProductId && prdK.IsExpired == false)
                                    .Take(item.Quantity);
                                if (prdKey != null)
                                {
                                    OrderHistoryADO.Insert(userInf.Username);
                                    var orderHistoryOfCus = CuongNMContext.INSTANCE.OrderHistories
                                    .Where(ord => ord.UserUsername.Equals(useAcc))
                                    .OrderByDescending(x => x.OrderId).FirstOrDefault();

                                    foreach (var k in prdKey)
                                    {
                                        OrderDetail orderDetail = new OrderDetail()
                                        {
                                            ProductSoldName = k.ProductProduct.ProductName,
                                            OrderHistoryOrderId = orderHistoryOfCus.OrderId,
                                            ProductKey = k.ProductKey1,
                                            ExpirationDate = k.ExpirationDate,
                                        };
                                        CuongNMContext.INSTANCE.OrderDetails.Add(orderDetail);
                                        userBal.Amount -= k.ProductProduct.Price;
                                        BalanceHistory balHis = new BalanceHistory()
                                        {
                                            UserUsername = useAcc,
                                         Status = false,
                                            Amount = k.ProductProduct.Price,
                                            Reason = "Buy " + k.ProductProduct.ProductName + ".",
                                            ChangeDate = DateTime.Now,
                                            NewBalance = userBal.Amount
                                        };
                                        messageBody += "<p>Product: " + k.ProductProduct.ProductName + "</p><br>" +
                                            "<p>Product Key: " + k.ProductKey1 + "</p><br>";
                                        CuongNMContext.INSTANCE.ProductKeys.Remove(k);


                                        var productInCartOfCustomer = CuongNMContext.INSTANCE.CartItems
                                        .Where(cartI => cartI.ProductProductId == item.ProductInf.ProductId && cartI.UserUsername.Equals(useAcc)).FirstOrDefault();
                                        if (productInCartOfCustomer != null)
                                        {
                                            CuongNMContext.INSTANCE.CartItems.Remove(productInCartOfCustomer);
                                        }
                                    }
                                }
                            }
                            var cartTotalOfCus = CuongNMContext.INSTANCE.Carts.Find(useAcc);
                            cartTotalOfCus.Total = 0;
                            CuongNMContext.INSTANCE.Carts.Update(cartTotalOfCus);
                            CuongNMContext.INSTANCE.UserBalances.Update(userBal);
                            CuongNMContext.INSTANCE.SaveChanges();
                            await _emailSender.SendEmailAsync(userInf.Email, "Thanks for order", messageHeader + messageBody, true);
                            return RedirectToAction("Index", "Cart");
                        }
                        else
                        {
                            return RedirectToAction("Index", "Cart");
                        }

                    }
                }
                else
                {
                    return RedirectToAction("Index", "Login");
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
    }
}
