using AutoMapper;
using SPSP.Models;
using SPSP.Models.Request.Customer;
using SPSP.Models.Request.Employee;
using SPSP.Models.Request.MenuItem;
using SPSP.Models.Request.Order;
using SPSP.Models.Request.OrderItem;
using SPSP.Models.Request.PaymentGatewayData;
using SPSP.Models.Request.Promotion;
using SPSP.Models.Request.PurchaseInvoice;
using SPSP.Models.Request.PurchaseInvoiceItem;
using SPSP.Models.Request.Reservation;
using SPSP.Models.Request.SaleInvoice;
using SPSP.Models.Request.SaleInvoiceItem;
using SPSP.Models.Request.UserAccount;

namespace SPSP.Services.Configurations
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Menu, Models.Menu>();

            CreateMap<Database.MenuItem, Models.MenuItem>();
            CreateMap<MenuItemCreateRequest, Database.MenuItem>();
            CreateMap<MenuItemUpdateRequest, Database.MenuItem>();


            CreateMap<Database.MenuItemPrediction, Models.MenuItemPrediction>();
            //CreateMap<MenuItemCreateRequest, Database.MenuItem>();
            //CreateMap<MenuItemUpdateRequest, Database.MenuItem>();

            CreateMap<Database.Order, Models.Order>();
            CreateMap<OrderCreateRequest, Database.Order>();
            CreateMap<OrderUpdateRequest, Database.Order>();

            CreateMap<Database.OrderItem, Models.OrderItem>();
            CreateMap<OrderItemCreateRequest, Database.OrderItem>();
            CreateMap<OrderItemUpdateRequest, Database.OrderItem>();

            CreateMap<Database.Category, Models.Category>();

            CreateMap<Database.QRTable, Models.QRTable>();

            CreateMap<Database.Reservation, Models.Reservation>();
            CreateMap<ReservationCreateRequest, Database.Reservation>();
            CreateMap<ReservationUpdateRequest, Database.Reservation>();

            CreateMap<Database.Employee, Models.Employee>();
            CreateMap<EmployeeCreateRequest, Database.Employee>();
            CreateMap<EmployeeUpdateRequest, Database.Employee>();

            CreateMap<Database.Customer, Models.Customer>();
            CreateMap<CustomerCreateRequest, Database.Customer>();
            CreateMap<CustomerUpdateRequest, Database.Customer>();

            CreateMap<Database.UserAccount, Models.UserAccount>();
            CreateMap<UserAccountCreateRequest, Database.UserAccount>();
            CreateMap<UserAccountUpdateRequest, Database.UserAccount>();

            CreateMap<Database.UserAccountUserRole, UserAccountUserRole>();
            CreateMap<Database.UserRole, UserRole>();

            CreateMap<Database.SaleInvoice, Models.SaleInvoice>();
            CreateMap<SaleInvoiceCreateRequest, Database.SaleInvoice>();

            CreateMap<Database.SaleInvoiceItem, Models.SaleInvoiceItem>();
            CreateMap<SaleInvoiceItemCreateRequest, Database.SaleInvoiceItem>();

            CreateMap<Database.PurchaseInvoice, Models.PurchaseInvoice>();
            CreateMap<PurchaseInvoiceCreateRequest, Database.PurchaseInvoice>();

            CreateMap<Database.PurchaseInvoiceItem, Models.PurchaseInvoiceItem>();
            CreateMap<PurchaseInvoiceItemCreateRequest, Database.PurchaseInvoiceItem>();

            CreateMap<Database.PaymentGatewayData, Models.PaymentGatewayData>();
            CreateMap<PaymentGatewayDataCreateRequest, Database.PaymentGatewayData>();


            CreateMap<Database.Promotion, Models.Promotion>();
            CreateMap<PromotionCreateRequest, Database.Promotion>();
            CreateMap<PromotionUpdateRequest, Database.Promotion>();
        }
    }
}


