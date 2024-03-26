
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ShopKey.Models;
using ShopKey.Utils;

namespace ShopKey.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.username = "";
            return View();
        }
        [HttpPost]
        public IActionResult Index(IFormCollection f)
        {
            String username = f["username"];
            String password = f["password"];
            var urs =CuongNMContext.INSTANCE.Users.Find(username);
            if (urs == null)
            {
                ViewBag.loginUsernameErr = "Username does not exists!";
            }
            else
            {
                if (urs.Password == EncryptionMethods.SHA256Encrypt(password))
                {
                    HttpContext.Session.SetString("userAcc", urs.Username);
                    if (urs.RoleRoleId == 1)
                    {
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        return RedirectToAction("Index", "Admin");
                    }
                }
                else
                {
                    ViewBag.loginPasswordErr = "Incorrect password!";
                }

            }
            ViewBag.username = username;
            return View();
        }
    }
}
