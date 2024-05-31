using Microsoft.EntityFrameworkCore;
using SPSP.Services.Database.SeedData;
using System.Text.RegularExpressions;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class DataDbContext : DbContext
    {
        public DataDbContext()
        {
        }

        public DataDbContext(DbContextOptions<DataDbContext> options)
            : base(options)
        {
        }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Employee> Employees { get; set; }
        public virtual DbSet<Menu> Menus { get; set; }
        public virtual DbSet<MenuItem> MenuItems { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<PurchaseInvoice> PurchaseInvoices { get; set; }
        public virtual DbSet<PurchaseInvoiceItem> PurchaseInvoiceItems { get; set; }
        public virtual DbSet<PaymentGatewayData> PaymentGatewayDatas { get; set; }
        public virtual DbSet<QRTable> QRTables { get; set; }
        public virtual DbSet<Reservation> Reservations { get; set; }
        public virtual DbSet<SaleInvoice> SaleInvoices { get; set; }
        public virtual DbSet<SaleInvoiceItem> SaleInvoiceItems { get; set; }
        public virtual DbSet<UserAccount> UserAccounts { get; set; }
        public virtual DbSet<UserAccountUserRole> UserAccountUserRoles { get; set; }
        public virtual DbSet<UserRole> UserRoles { get; set; }
        public virtual DbSet<TrainedData> TrainedDatas { get; set; }
        public virtual DbSet<MenuItemPrediction> MenuItemPredictions { get; set; }
        public virtual DbSet<Promotion> Promotions { get; set; }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{

        //}

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Bosnian_Latin_100_CI_AI");



            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");

                entity.HasIndex(e => e.Code, "UQ__Category__A25C5AA75505BED9")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");
            });

            modelBuilder.Entity<Customer>(entity =>
            {
                entity.ToTable("Customer");

                entity.HasIndex(e => e.UserAccountId, "IX_Customer_UserAccountId");

                entity.Property(e => e.Address).HasMaxLength(255);

                entity.Property(e => e.Phone).HasMaxLength(20);

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.UserAccount)
                    .WithMany(p => p.Customers)
                    .HasForeignKey(d => d.UserAccountId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Customer_UserAccountId");
            });

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.ToTable("Employee");


                entity.HasIndex(e => e.UserAccountId, "IX_Employee_UserAccountId");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.UserAccount)
                    .WithMany(p => p.Employees)
                    .HasForeignKey(d => d.UserAccountId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Employee_UserAccountId");
            });

            modelBuilder.Entity<Menu>(entity =>
            {
                entity.ToTable("Menu");

                entity.Property(e => e.Name).HasMaxLength(255);

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

            });

            modelBuilder.Entity<MenuItem>(entity =>
            {
                entity.ToTable("MenuItem");

                entity.HasIndex(e => e.CategoryId, "IX_MenuItem_CategoryId");

                entity.HasIndex(e => new { e.MenuId, e.Code }, "UC_Code")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.CategoryId)
                    .HasConstraintName("FK_MenuItem_CategoryId");

                entity.HasOne(d => d.Menu)
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.MenuId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MenuItem_MenuId");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("Order");

                entity.HasIndex(e => e.CustomerId, "IX_Order_CustomerId");

                entity.HasIndex(e => e.QRTableId, "IX_Order_QRTableId");

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.TotalAmount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.TotalAmountWithVAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.VAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.VATAmount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.CustomerId)
                    .HasConstraintName("FK_Order_CustomerId");

                entity.HasOne(d => d.QRTable)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.QRTableId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Order_QRTableId");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.ToTable("OrderItem");

                entity.HasIndex(e => e.MenuItemId, "IX_OrderItem_MenuItemId");

                entity.HasIndex(e => e.OrderId, "IX_OrderItem_OrderId");

                entity.Property(e => e.Subtotal).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_OrderItem_MenuItemId");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_OrderItem_OrderId");
            });

            modelBuilder.Entity<PurchaseInvoice>(entity =>
            {
                entity.ToTable("PurchaseInvoice");

                entity.HasIndex(e => e.EmployeeId, "IX_PurchaseInvoice_EmployeeId");

                entity.Property(e => e.InvoiceNumber)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Note).HasMaxLength(255);

                entity.Property(e => e.TotalAmount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.TotalAmountWithVAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.VAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.PaymentGatewayData)
                    .WithMany(p => p.PurchaseInvoices)
                    .HasForeignKey(d => d.PaymentGatewayDataId)
                    .HasConstraintName("FK_PurchaseInvoice_PaymentGatewayDataId");

                entity.HasOne(d => d.Employee)
                    .WithMany(p => p.PurchaseInvoices)
                    .HasForeignKey(d => d.EmployeeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PurchaseInvoice_EmployeeId");
            });

            modelBuilder.Entity<PurchaseInvoiceItem>(entity =>
            {
                entity.ToTable("PurchaseInvoiceItem");

                entity.HasIndex(e => e.MenuItemId, "IX_PurchaseInvoiceItem_MenuItemId");

                entity.HasIndex(e => e.PurchaseInvoiceId, "IX_PurchaseInvoiceItem_PurchaseInvoiceId");

                entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.PurchaseInvoiceItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PurchaseInvoiceItem_MenuItemId");

                entity.HasOne(d => d.PurchaseInvoice)
                    .WithMany(p => p.PurchaseInvoiceItems)
                    .HasForeignKey(d => d.PurchaseInvoiceId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PurchaseInvoiceItem_PurchaseInvoiceId");
            });

            modelBuilder.Entity<PaymentGatewayData>(entity =>
            {
                entity.ToTable("PaymentGatewayData");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");


            });

            modelBuilder.Entity<QRTable>(entity =>
            {
                entity.ToTable("QRTable");

                entity.Property(e => e.QRCode)
                    .HasColumnType("VARBINARY(MAX)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");


            });

            modelBuilder.Entity<Reservation>(entity =>
            {
                entity.ToTable("Reservation");

                entity.HasIndex(e => e.CustomerId, "IX_Reservation_CustomerId");

                entity.HasIndex(e => e.QRTableId, "IX_Reservation_QRTableId");

                entity.Property(e => e.ContactInfo).HasMaxLength(255);

                entity.Property(e => e.SpecialRequest).HasMaxLength(255);

                entity.Property(e => e.Status).HasMaxLength(50);

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.CustomerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Reservation_CustomerId");

                entity.HasOne(d => d.QRTable)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.QRTableId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Reservation_QRTableId");
            });

            modelBuilder.Entity<SaleInvoice>(entity =>
            {
                entity.ToTable("SaleInvoice");

                entity.HasIndex(e => e.EmployeeId, "IX_SaleInvoice_EmployeeId");

                entity.HasIndex(e => e.OrderId, "IX_SaleInvoice_OrderId");

                entity.Property(e => e.InvoiceNumber)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.TotalAmount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.TotalAmountWithVAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.VAT).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.VATAmount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Employee)
                    .WithMany(p => p.SaleInvoices)
                    .HasForeignKey(d => d.EmployeeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SaleInvoice_EmployeeId");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.SaleInvoices)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SaleInvoice_OrderId");
            });

            modelBuilder.Entity<SaleInvoiceItem>(entity =>
            {
                entity.ToTable("SaleInvoiceItem");

                entity.HasIndex(e => e.MenuItemId, "IX_SaleInvoiceItem_MenuItemId");

                entity.HasIndex(e => e.SaleInvoiceId, "IX_SaleInvoiceItem_SaleInvoiceId");

                entity.Property(e => e.Discount).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.SaleInvoiceItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SaleInvoiceItem_MenuItemId");

                entity.HasOne(d => d.SaleInvoice)
                    .WithMany(p => p.SaleInvoiceItems)
                    .HasForeignKey(d => d.SaleInvoiceId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SaleInvoiceItem_SaleInvoiceId");
            });

            modelBuilder.Entity<UserAccount>(entity =>
            {
                entity.ToTable("UserAccount");

                entity.HasIndex(e => e.Username, "UQ__UserAcco__536C85E4249C94D1")
                    .IsUnique()
                    .HasFilter("([Username] IS NOT NULL)");

                entity.HasIndex(e => e.Email, "UQ__UserAcco__A9D10534C2A79D0E")
                    .IsUnique();

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.PasswordHash).HasMaxLength(255);

                entity.Property(e => e.PasswordSalt).HasMaxLength(255);

                entity.Property(e => e.Username).HasMaxLength(255);

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");
            });

            modelBuilder.Entity<UserAccountUserRole>(entity =>
            {
                entity.ToTable("UserAccountUserRole");

                entity.HasIndex(e => e.UserAccountId, "IX_UserAccountUserRole_UserAccountId");

                entity.HasIndex(e => e.UserRoleId, "IX_UserAccountUserRole_UserRoleId");

                entity.Property(e => e.Valid)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.UserAccount)
                    .WithMany(p => p.UserAccountUserRoles)
                    .HasForeignKey(d => d.UserAccountId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserAccountUserRole_UserAccountId");

                entity.HasOne(d => d.UserRole)
                    .WithMany(p => p.UserAccountUserRoles)
                    .HasForeignKey(d => d.UserRoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UserAccountUserRole_UserRoleId");
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.ToTable("UserRole");

                entity.HasIndex(e => e.Name, "UQ__UserRole__737584F659087FEA")
                    .IsUnique();

                entity.HasIndex(e => e.Code, "UQ__UserRole__A25C5AA780869A0D")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Valid)
                .IsRequired()
                    .HasDefaultValueSql("((1))");
            });

            modelBuilder.Entity<TrainedData>(entity =>
            {
                entity.ToTable("TrainedData");

            });

            modelBuilder.Entity<MenuItemPrediction>(entity =>
            {
                entity.ToTable("MenuItemPrediction");

                modelBuilder.Entity<MenuItemPrediction>()
                    .HasOne(m => m.MainMenuItem)
                    .WithMany(m => m.MainMenuItems)
                    .HasForeignKey(m => m.MainMenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MenuItemPrediction_MainMenuItemId");

                modelBuilder.Entity<MenuItemPrediction>()
                    .HasOne(m => m.RecommendedMenuItem)
                    .WithMany(m => m.RecommendedMenuItems)
                    .HasForeignKey(m => m.RecommendedMenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MenuItemPrediction_RecommendedMenuItemId");

            });

            modelBuilder.Entity<Promotion>(entity =>
            {
                entity.ToTable("Promotion");

                modelBuilder.Entity<Promotion>()
                    .HasOne(m => m.MenuItem)
                    .WithMany(m => m.Promotions)
                    .HasForeignKey(m => m.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Promotion_MenuItemId");
            });

            modelBuilder.Entity<Category>().SeedData();
            modelBuilder.Entity<Menu>().SeedData();
            modelBuilder.Entity<MenuItem>().SeedData();
            modelBuilder.Entity<UserAccount>().SeedData();
            modelBuilder.Entity<UserRole>().SeedData();
            modelBuilder.Entity<UserAccountUserRole>().SeedData();
            modelBuilder.Entity<Customer>().SeedData();
            modelBuilder.Entity<Employee>().SeedData();
            modelBuilder.Entity<PurchaseInvoice>().SeedData();
            modelBuilder.Entity<PurchaseInvoiceItem>().SeedData();
            modelBuilder.Entity<QRTable>().SeedData();
            modelBuilder.Entity<Order>().SeedData();
            modelBuilder.Entity<OrderItem>().SeedData();
            modelBuilder.Entity<SaleInvoice>().SeedData();
            modelBuilder.Entity<SaleInvoiceItem>().SeedData();
            modelBuilder.Entity<Reservation>().SeedData();
            modelBuilder.Entity<Promotion>().SeedData();

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
