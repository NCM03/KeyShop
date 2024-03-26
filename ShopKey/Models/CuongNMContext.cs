using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ShopKey.Models
{
    public partial class CuongNMContext : DbContext
    {
        public static CuongNMContext INSTANCE = new CuongNMContext();
        public CuongNMContext()
        {
            if (INSTANCE == null)
            {
                INSTANCE = this;
            }
        }

        public CuongNMContext(DbContextOptions<CuongNMContext> options)
            : base(options)
        {
        }

      
        public virtual DbSet<BalanceHistory> BalanceHistories { get; set; } = null!;
        public virtual DbSet<Cart> Carts { get; set; } = null!;
        public virtual DbSet<CartItem> CartItems { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<DepositHistory> DepositHistories { get; set; } = null!;
        public virtual DbSet<OrderDetail> OrderDetails { get; set; } = null!;
        public virtual DbSet<OrderHistory> OrderHistories { get; set; } = null!;
        public virtual DbSet<Product> Products { get; set; } = null!;
        public virtual DbSet<ProductKey> ProductKeys { get; set; } = null!;
        public virtual DbSet<Role> Roles { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<UserBalance> UserBalances { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var builder = new ConfigurationBuilder().
                    SetBasePath(Directory.GetCurrentDirectory()).

                AddJsonFile("appsettings.json", optional: false);

                IConfiguration con = builder.Build();

                optionsBuilder.UseSqlServer(con.GetConnectionString("DBContext"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BalanceHistory>(entity =>
            {
                entity.ToTable("BalanceHistory");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ChangeDate).HasColumnType("datetime");

                entity.Property(e => e.Reason)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithMany(p => p.BalanceHistories)
                    .HasForeignKey(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("BalanceHistory_HE172187_User_HE172187");
            });

            modelBuilder.Entity<Cart>(entity =>
            {
                entity.HasKey(e => e.UserUsername)
                    .HasName("Cart_HE172187_pk");

                entity.ToTable("Cart");

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithOne(p => p.Cart)
                    .HasForeignKey<Cart>(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Cart_HHE172187_User_HE172187");
            });

            modelBuilder.Entity<CartItem>(entity =>
            {
                entity.HasKey(e => e.ItemId)
                    .HasName("CartItem_HE172187_pk");

                entity.ToTable("CartItem");

                entity.Property(e => e.ItemId).HasColumnName("ItemID");

                entity.Property(e => e.ProductProductId).HasColumnName("Product_ProductID");

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.ProductProduct)
                    .WithMany(p => p.CartItems)
                    .HasForeignKey(d => d.ProductProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("CartItem_HE172187_Product_HE172187");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithMany(p => p.CartItems)
                    .HasForeignKey(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("CartItem_HE172187_Cart_HE172187");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.CategoryName).HasMaxLength(255);
            });

            modelBuilder.Entity<DepositHistory>(entity =>
            {
                entity.HasKey(e => e.DepositId)
                    .HasName("DepositRequest_HE172187_pk");

                entity.ToTable("DepositHistory");

                entity.Property(e => e.DepositId).HasColumnName("DepositID");

                entity.Property(e => e.ActionBy)
                    .HasMaxLength(25)
                    .IsUnicode(false);

                entity.Property(e => e.ActionDate).HasColumnType("datetime");

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithMany(p => p.DepositHistories)
                    .HasForeignKey(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("DepositRequest_HE172187_User_HE172187");
            });

            modelBuilder.Entity<OrderDetail>(entity =>
            {
                entity.ToTable("OrderDetail");

                entity.Property(e => e.OrderDetailId).HasColumnName("OrderDetailID");

                entity.Property(e => e.ExpirationDate)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.OrderHistoryOrderId).HasColumnName("OrderHistory_OrderID");

                entity.Property(e => e.ProductKey)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ProductSoldName).HasMaxLength(255);

                entity.HasOne(d => d.OrderHistoryOrder)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.OrderHistoryOrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("OrderDetail_HE172187_OrderHistory_HE172187");
            });

            modelBuilder.Entity<OrderHistory>(entity =>
            {
                entity.HasKey(e => e.OrderId)
                    .HasName("OrderHistory_HE172187_pk");

                entity.ToTable("OrderHistory");

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithMany(p => p.OrderHistories)
                    .HasForeignKey(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("OrderHistory_HE172187_User_HE172187");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("Product");

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.CategoryCategoryId).HasColumnName("Category_CategoryID");

                entity.Property(e => e.ProductName).HasMaxLength(255);
            });

            modelBuilder.Entity<ProductKey>(entity =>
            {
                entity.HasKey(e => e.KeyId)
                    .HasName("ProductKey_HE172187_pk");

                entity.ToTable("ProductKey");

                entity.Property(e => e.KeyId).HasColumnName("KeyID");

                entity.Property(e => e.ExpirationDate)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IsExpired).HasColumnName("isExpired");

                entity.Property(e => e.ProductKey1)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("ProductKey");

                entity.Property(e => e.ProductProductId).HasColumnName("Product_ProductID");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("Role");

                entity.Property(e => e.RoleId).HasColumnName("RoleID");

                entity.Property(e => e.RoleName).HasMaxLength(50);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.Username)
                    .HasName("User_HE172187_pk");

                entity.ToTable("User");

                entity.Property(e => e.Username)
                    .HasMaxLength(25)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName).HasMaxLength(75);

                entity.Property(e => e.LastName).HasMaxLength(75);

                entity.Property(e => e.Password)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.RoleRoleId).HasColumnName("Role_RoleID");

                entity.HasOne(d => d.RoleRole)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.RoleRoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("User_Role");
            });

            modelBuilder.Entity<UserBalance>(entity =>
            {
                entity.HasKey(e => e.UserUsername)
                    .HasName("UserBalance_HE172187_pk");

                entity.ToTable("UserBalance");

                entity.Property(e => e.UserUsername)
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasColumnName("User_Username");

                entity.HasOne(d => d.UserUsernameNavigation)
                    .WithOne(p => p.UserBalance)
                    .HasForeignKey<UserBalance>(d => d.UserUsername)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("UserBalance_HE172187_User_HE172187");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
