using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace ShopKey.Controllers
{
    public class OrderHistoryController : Controller
    {
        public bool CanAccessThisPage()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    if (userInf.RoleRoleId == 1 && userInf.IsActive == true)
                    {
                        var roleList =CuongNMContext.INSTANCE.Roles.ToArray();
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
            bool canAccess = CanAccessThisPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    var orderHis =CuongNMContext.INSTANCE.OrderHistories
                        .Where(order => order.UserUsername == userInf.Username)
                        .Select(entity => new
                        {
                            OrderId = entity.OrderId,
                            UserUsername = entity.UserUsername,
                            OrderDetailHe173252 = entity.OrderDetails
                        })
                        .OrderByDescending(ord => ord.OrderId);
                    ViewBag.orderHis = orderHis;
                }
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
    }
}
