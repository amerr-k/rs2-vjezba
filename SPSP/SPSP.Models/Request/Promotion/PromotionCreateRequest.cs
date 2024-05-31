using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.Promotion
{
    public class PromotionCreateRequest
    {
        [Required]
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public string? Description { get; set; }
        public bool? Active { get; set; }
        [Required]
        public int MenuItemId { get; set; }
    }
}

