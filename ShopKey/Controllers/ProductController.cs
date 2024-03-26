using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;

namespace License_Key_Shop_Web.Controllers
{
    public class ProductController : Controller
    {
        public void loadUserInf()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                ViewBag.userInf = userInf;
            }
        }
        public IActionResult Index()
        {
            loadUserInf();
            var prdList =CuongNMContext.INSTANCE.Products.ToList();
            ViewBag.prdList = prdList;
            return View();
        }

        public IActionResult Details(int Id)
        {
            loadUserInf();
            var prdDetails =CuongNMContext.INSTANCE.Products.Find(Id);
            ViewBag.prdDetails = prdDetails;
            return View();
        }
    }
}
