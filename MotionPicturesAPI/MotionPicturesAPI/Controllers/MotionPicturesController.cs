using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotionPicturesAPI.Data;
using MotionPicturesAPI.Models;

namespace MotionPicturesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MotionPicturesController : ControllerBase
    {
        private readonly MotionPicturesAPIContext _context;

        public MotionPicturesController(MotionPicturesAPIContext context)
        {
            _context = context;
        }

        // GET: api/MotionPictures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<MotionPicture>>> GetMotionPicture()
        {
            return await _context.MotionPicture.ToListAsync();
        }

        // GET: api/MotionPictures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<MotionPicture>> GetMotionPicture(int id)
        {
            var motionPicture = await _context.MotionPicture.FindAsync(id);

            if (motionPicture == null)
            {
                return NotFound();
            }

            return motionPicture;
        }

        // PUT: api/MotionPictures/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMotionPicture(int id, MotionPicture motionPicture)
        {
            if (id != motionPicture.Id)
            {
                return BadRequest();
            }

            _context.Entry(motionPicture).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MotionPictureExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/MotionPictures
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<MotionPicture>> PostMotionPicture(MotionPicture motionPicture)
        {
            _context.MotionPicture.Add(motionPicture);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetMotionPicture", new { id = motionPicture.Id }, motionPicture);
        }

        // DELETE: api/MotionPictures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMotionPicture(int id)
        {
            var motionPicture = await _context.MotionPicture.FindAsync(id);
            if (motionPicture == null)
            {
                return NotFound();
            }

            _context.MotionPicture.Remove(motionPicture);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MotionPictureExists(int id)
        {
            return _context.MotionPicture.Any(e => e.Id == id);
        }
    }
}
