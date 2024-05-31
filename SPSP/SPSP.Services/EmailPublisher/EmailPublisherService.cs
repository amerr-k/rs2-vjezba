using EasyNetQ;
using Microsoft.Extensions.Configuration;

namespace SPSP.Services.OrderEmailPublisher
{
    public class EmailPublisherService : IEmailPublisherService
    {
        private readonly IBus bus;

        public EmailPublisherService(IConfiguration configuration)
        {
            var rabbitMQHost = configuration["RABBITMQ_HOST"] ?? "localhost";
            var rabbitMQUsername = configuration["RABBITMQ_USERNAME"] ?? "guest";
            var rabbitMQPassword = configuration["RABBITMQ_PASSWORD"] ?? "guest";
            var rabbitMQVirtualHost = configuration["RABBITMQ_VIRTUALHOST"] ?? "/";

            var rabbitMQConnectionString = $"host={rabbitMQHost};username={rabbitMQUsername};password={rabbitMQPassword};virtualHost={rabbitMQVirtualHost}";

            this.bus = RabbitHutch.CreateBus(rabbitMQConnectionString);
            //this.bus = RabbitHutch.CreateBus("host=localhost");
        }
        public void PublishSaleInvoiceEmail(Models.EmailMessage emailMessage)
        {
            bus.PubSub.Publish(emailMessage, "email-queue");

        }
    }
}
