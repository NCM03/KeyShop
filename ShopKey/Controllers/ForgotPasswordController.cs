
using ShopKey.Utils;
using Microsoft.AspNetCore.Mvc;
using ShopKey.MyInterface;
using ShopKey.Models;

namespace ShopKey.Controllers
{
    public class ForgotPasswordController : Controller
    {
        private readonly IEmailSender _emailSender;
        public ForgotPasswordController(IEmailSender emailSender)
        {
            this._emailSender = emailSender;
        }
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult GetCode()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> GetCode(IFormCollection f)
        {
            string email = f["email"];
            var userInf =CuongNMContext.INSTANCE.Users
                .Where(x => x.Email.Equals(email))
                .FirstOrDefault();
            if (userInf != null)
            {
                string code = CodeGenerator.GenerateRandomString(6);
                HttpContext.Session.SetString("verificationCode", code);
                await _emailSender.SendEmailAsync(userInf.Email, "Thanks for order", "Your code to set new password is: " + code, true);
                TempData["email"] = email;
                return View();
            }
            else
            {
                TempData["emailNotExistErr"] = "This email does not belong to any user!";
                TempData["email"] = email;
                return RedirectToAction("Index", "ForgotPassword");
            }
        }

        public IActionResult SetNewPass()
        {
            return View();
        }

        [HttpPost]
        public IActionResult SetNewPass(IFormCollection f)
        {
            string email = f["email"];
            string enteredCode = f["code"];
            string sentCode = HttpContext.Session.GetString("verificationCode");
            if (sentCode != null)
            {
                if (sentCode.Equals(enteredCode))
                {
                    TempData["email"] = email;
                    return View();
                }
                else
                {
                    TempData["incorrectCodeErr"] = "Entered code is incorrect!";
                    TempData["email"] = email;
                    return RedirectToAction("GetCode", "ForgotPassword");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public IActionResult ConfirmNewPassword(IFormCollection f)
        {
            string email = f["email"];
            string newPass = f["newPass"];
            string confirmPass = f["confirmPass"];
            if (newPass.Equals(confirmPass))
            {
                var userInf =CuongNMContext.INSTANCE.Users
                .Where(x => x.Email.Equals(email))
                .FirstOrDefault();
                userInf.Password = EncryptionMethods.SHA256Encrypt(newPass);
               CuongNMContext.INSTANCE.Users.Update(userInf);
               CuongNMContext.INSTANCE.SaveChanges();
                return RedirectToAction("Index", "Login");
            } else
            {
                TempData["confirmPassErr"] = "Confirm password is incorrect!";
                TempData["email"] = email;
                return RedirectToAction("SetNewPass", "ForgotPassword");
            }
        }
    }
}
