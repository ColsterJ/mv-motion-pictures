using System.ComponentModel.DataAnnotations.Schema;

namespace MotionPicturesAPI.Models
{
    [Table("MotionPictures")]
    public class MotionPicture
    {
        public int Id { get; set; }
        public string Name { get; set; } = default!;
        public string Description { get; set; } = default!;
        [Column("Release Year")]
        public int ReleaseYear { get; set; }
    }
}
