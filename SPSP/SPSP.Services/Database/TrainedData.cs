using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Services.Database
{
    public class TrainedData
    {
        public int Id { get; set; } 
        public byte[] Data { get; set; }
        public DateTime TrainedDateTime { get; set; }
    }
}
