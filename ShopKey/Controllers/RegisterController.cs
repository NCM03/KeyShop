using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;
using ShopKey.Utils;

namespace ShopKey.Controllers
{
    public class RegisterController : Controller
    {
        public IActionResult Index()
        {
            User userBasicInf = new User() { FirstName = "", LastName = "", Username = "", Email = "" };
            ViewBag.basicInf = userBasicInf;
            return View();
        }
        [HttpPost]
        public IActionResult Index(IFormCollection f)
        {
            String firstName = f["firstName"];
            String lastName = f["lastName"];
            String username = f["username"];
            String email = f["email"];
            String password = f["password"];
            String confirmPassword = f["confirmPassword"];
            var usr1= CuongNMContext.INSTANCE.Users.FirstOrDefault(x=>x.Email.Equals(email));
            if (username.Length > 16)
            {
                ViewBag.registerUsernameErr = "Username charaters <16";
            }
            else
            {
                if (password.Length < 8 && password.Length > 100)
                {
                    ViewBag.registerUsernameErr = "The number of characters in the password must be at least 8 characters and less than 100";
                }
                else
                {
                    if (confirmPassword.Equals(password))
                    {
                        if (usr1 != null)
                        {
                            ViewBag.registerMailErr = "Mail is already exists!";
                        }
                        else
                        {
                            var usr = CuongNMContext.INSTANCE.Users.Find(username);
                            if (usr != null)
                            {
                                ViewBag.registerUsernameErr = "This username already exists!";
                            }
                            else
                            {


                                User userInf = new User()
                                {
                                    FirstName = firstName,
                                    LastName = lastName,
                                    Username = username,
                                    Email = email,
                                    Password = EncryptionMethods.SHA256Encrypt(password),
                                    RoleRoleId = 1,
                                    IsActive = true,
                                    IsVerified = false,
                                };
                                CuongNMContext.INSTANCE.Users.Add(userInf);
                                Cart userCart = new Cart()
                                {
                                    UserUsername = username,
                                    Total = 0,
                                };
                                CuongNMContext.INSTANCE.Carts.Add(userCart);
                                UserBalance userBal = new UserBalance()
                                {
                                    UserUsername = username,
                                    Amount = 0,
                                };
                                CuongNMContext.INSTANCE.UserBalances.Add(userBal);
                                CuongNMContext.INSTANCE.SaveChanges();
                                return RedirectToAction("Index", "Login");

                            }
                        }
                    }
                    else
                    {
                        ViewBag.registerPassErr = "Confirm password does not match!";
                    }
                }
            }
            
                User userBasicInf = new User()
                {
                    FirstName = firstName,
                    LastName = lastName,
                    Username = username,
                    Email = email,
                };
                ViewBag.basicInf = userBasicInf;
                return View();
            

        }
    }
}
