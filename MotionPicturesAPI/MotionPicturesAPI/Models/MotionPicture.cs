namespace MotionPicturesAPI.Models
{
    public class MotionPicture
    {
        public int Id { get; set; }
        public string Name { get; set; } = default!;
        public string Description { get; set; } = default!;
        public int ReleaseYear { get; set; }
    }
}
