using System;
using System.Collections.Generic;

namespace ShopKey.Models
{
    public partial class ProductKey
    {
        public int KeyId { get; set; }
        public int ProductProductId { get; set; }
        public string ProductKey1 { get; set; } = null!;
        public string? ExpirationDate { get; set; }
        public bool IsExpired { get; set; }
        public string getFormatedKeyValue()
        {
            return this.ProductKey1.Substring(0, 5) + "....." + this.ProductKey1.Substring(this.ProductKey1.Length - 6);
        }

        public virtual Product ProductProduct { get; set; } = null!;
    }
}

