using System;
using System.Collections.Generic;

namespace ShopKey.Models
{
    public partial class CartItem
    {
        public int ItemId { get; set; }
        public string UserUsername { get; set; } = null!;
        public int ProductProductId { get; set; }
        public int Quantity { get; set; }

        public virtual Product ProductProduct { get; set; } = null!;
        public virtual Cart UserUsernameNavigation { get; set; } = null!;
    }
}
