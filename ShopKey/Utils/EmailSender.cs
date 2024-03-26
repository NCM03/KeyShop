using ShopKey.MyInterface;
using System.Net;
using System.Net.Mail;

namespace ShopKey.Utils
{
    public class EmailSender : IEmailSender
    {
        public Task SendEmailAsync(string email, string subject, string message, bool isBodyHtml)
        {
            var senderMail = "sieunhantanh2003@gmail.com";
            var senderPassword = "dqrelklikvyngkbv";
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true,
                Credentials = new NetworkCredential(senderMail, senderPassword)
            };

            var senderAddress = new MailAddress(senderMail, "NCM Key Shop");
            var mailMessage = new MailMessage
            {
                From = senderAddress,
                Subject = subject,
                Body = message,
                IsBodyHtml = true
            };

            mailMessage.To.Add(email);

            return client.SendMailAsync(mailMessage);
        }
    }
}
