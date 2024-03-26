using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;

namespace ShopKey.Controllers
{
    public class EmployeeManagementController : Controller
    {

        public bool CanAccessThisManagementPage()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    if (userInf.RoleRoleId != 1 && userInf.IsActive == true)
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
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var keyList =CuongNMContext.INSTANCE.ProductKeys.ToArray();
                ViewBag.keyList = keyList;
                var prdList =CuongNMContext.INSTANCE.Products.ToArray();
                ViewBag.prdList = prdList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
    }
}
