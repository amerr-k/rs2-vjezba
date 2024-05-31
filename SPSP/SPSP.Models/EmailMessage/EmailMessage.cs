using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models
{
    public class EmailMessage
    {
        public string Subject { get; set; }
        public string Body { get; set; }
        public byte[]? PdfAttachment { get; set; }
    }
}
