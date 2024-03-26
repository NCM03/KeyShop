namespace ShopKey.MyInterface
{
    public interface IEmailSender
    {

        Task SendEmailAsync(string email, string subject, string message, bool isBodyHtml);
    }
}
