using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.MenuItem
{
    public class MenuItemCreateRequest
    {
        [Required]
        public int MenuId { get; set; }
        public int? CategoryId { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(10)]
        public string Code { get; set; }
        public string? Description { get; set; }
        [Required]
        [Range(0, double.MaxValue)]
        public decimal Price { get; set; }
        public byte[]? Image { get; set; }
    }
}

