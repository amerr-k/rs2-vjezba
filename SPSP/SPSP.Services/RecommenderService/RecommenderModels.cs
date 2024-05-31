using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Services.RecommenderService
{
    public class RecommenderModels
    {
        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class ProductEntry
        {
            [KeyType(count: 19)]
            public uint ProductID { get; set; }

            [KeyType(count: 19)]
            public uint CoPurchaseProductID { get; set; }

            public float Label { get; set; }
        }
    }
}
