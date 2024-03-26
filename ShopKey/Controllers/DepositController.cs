using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;
using System;

namespace ShopKey.Controllers
{
    public class DepositController : Controller
    {
        public bool CanAccessThisAdminPage()
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
            bool canAccess = CanAccessThisAdminPage();
            if (canAccess)
            {
                string? useAcc = HttpContext.Session.GetString("userAcc");
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    var userBalance =CuongNMContext.INSTANCE.UserBalances.Find(useAcc);
                    ViewBag.userBalance = userBalance;
                    var depositHistoryList =CuongNMContext.INSTANCE.DepositHistories
                        .Where(deposit => deposit.UserUsername.Equals(useAcc))
                        .Select(entity => new
                        {
                            DepositId = entity.DepositId,
                            UserUsername = entity.UserUsername,
                            Amount = entity.Amount,
                            ActionDate = entity.ActionDate,
                            ActionBy = entity.ActionBy,
                        });
                    ViewBag.depositHistoryList = depositHistoryList;
                }
                ViewBag.userInf = userInf;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
    }
}
