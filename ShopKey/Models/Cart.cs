﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ShopKey.Models
{
    public partial class Cart
    {
        public Cart()
        {
            CartItems = new HashSet<CartItem>();
        }

        public string UserUsername { get; set; } = null!;
        public double Total { get; set; }
        public string GetFormattedTotal()
        {
            string amount = this.Total.ToString();
            StringBuilder formattedAmount = new StringBuilder();
            int endPoint = amount.IndexOf(".");
            if (endPoint < 0)
            {
                endPoint = amount.Length;
            }
            int count = 0;
            for (int i = endPoint - 1; i >= 0; i--)
            {
                formattedAmount.Insert(0, amount[i]);
                count++;

                if (count % 3 == 0 && i > 0)
                {
                    formattedAmount.Insert(0, ",");
                }
            }
            if (endPoint == amount.Length)
            {
                return formattedAmount.ToString();
            }
            else
            {
                return formattedAmount.ToString() + amount.Substring(endPoint);
            }
        }
        public virtual User UserUsernameNavigation { get; set; } = null!;
        public virtual ICollection<CartItem> CartItems { get; set; }
    }
}
