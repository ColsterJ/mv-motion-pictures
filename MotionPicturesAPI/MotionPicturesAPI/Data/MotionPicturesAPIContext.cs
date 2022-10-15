using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MotionPicturesAPI.Models;

namespace MotionPicturesAPI.Data
{
    public class MotionPicturesAPIContext : DbContext
    {
        public MotionPicturesAPIContext (DbContextOptions<MotionPicturesAPIContext> options)
            : base(options)
        {
        }

        public DbSet<MotionPicturesAPI.Models.MotionPicture> MotionPicture { get; set; } = default!;
    }
}
