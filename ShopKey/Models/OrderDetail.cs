using System;
using System.Collections.Generic;

namespace ShopKey.Models
{
    public partial class OrderDetail
    {
        public int OrderDetailId { get; set; }
        public string ProductSoldName { get; set; } = null!;
        public int OrderHistoryOrderId { get; set; }
        public string ProductKey { get; set; } = null!;
        public string? ExpirationDate { get; set; }

        public virtual OrderHistory OrderHistoryOrder { get; set; } = null!;
    }
}
