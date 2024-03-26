using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;

namespace ShopKey.Controllers
{
    public class DepositManagementController : Controller
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
                var depositHistoryList =CuongNMContext.INSTANCE.DepositHistories.ToArray();
                ViewBag.depositHistoryList = depositHistoryList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public IActionResult Create(IFormCollection f)
        {
            string username = f["username"];
            var userInf =CuongNMContext.INSTANCE.Users.Find(username);

            if (userInf != null && userInf.IsActive == true && userInf.RoleRoleId == 1)
            {
                float amount = float.Parse(f["amount"]);
                if (amount > 0)
                {
                    string? useAcc = HttpContext.Session.GetString("userAcc");
                    DateTime timeNow = DateTime.Now;

                    var userBalInf = CuongNMContext.INSTANCE.UserBalances.Find(username);
                    userBalInf.Amount += amount;
                    CuongNMContext.INSTANCE.UserBalances.Update(userBalInf);

                    BalanceHistory balHistory = new BalanceHistory()
                    {
                        UserUsername = username,
                        Status = true,
                        Amount = amount,
                        Reason = "Deposit Successfully.",
                        ChangeDate = timeNow,
                        NewBalance = userBalInf.Amount
                    };
                    CuongNMContext.INSTANCE.Add(balHistory);

                    DepositHistory depoHistoryInf = new DepositHistory()
                    {
                        UserUsername = username,
                        Amount = amount,
                        ActionDate = timeNow,
                        ActionBy = useAcc
                    };
                    CuongNMContext.INSTANCE.DepositHistories.Add(depoHistoryInf);
                    CuongNMContext.INSTANCE.SaveChanges();
                }
            }
            else
            {
                ViewBag.AmountErr = "Money should >=0";
            }
            return Redirect("/DepositManagement/Index");
        }
    }
}
