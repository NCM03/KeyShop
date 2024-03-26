using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;

namespace ShopKey.Controllers
{
    public class AdminController : Controller
    {

        public bool CanAccessThisAdminPage()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf = CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    if (userInf.RoleRoleId != 1 && userInf.IsActive == true)
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
                if (useAcc != null)
                {
                    LoadUserInf(useAcc);
                }
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public void LoadUserInf(string username)
        {
            
        }
    }
}
