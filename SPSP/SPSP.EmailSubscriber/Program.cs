using SPSP.EmailSubscriber;
using SPSP.EmailSubscriber.Utils;

IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((hostContext, services) =>
    {
        services.Configure<GmailSMTP>(hostContext.Configuration.GetSection("GmailSMTP"));

        services.AddHostedService<EmailSubscriberService>();
    })
    .Build();

await host.RunAsync();