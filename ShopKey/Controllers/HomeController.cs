using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShopKey.Models;

namespace ShopKey.Controllers
{
    public class HomeController : Controller
    {
        private readonly IConfiguration _configuration;
        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public IActionResult Index()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                ViewBag.userInf = userInf;
            }

            var random = new Random();

            var allProduct =CuongNMContext.INSTANCE.Products.ToList();
            var randomProduct = allProduct.OrderBy(r => random.Next()).Take(4).ToList();
            ViewBag.randomProduct = randomProduct;
            string currencyUnit = _configuration["CurrencyUnit"];
            ViewBag.currencyUnit = currencyUnit;
            return View();
        }
    }
}
