using EasyNetQ;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Services.OrderEmailPublisher
{
    public interface IEmailPublisherService
    {
        void PublishSaleInvoiceEmail(Models.EmailMessage emailMessage);
    }
}
