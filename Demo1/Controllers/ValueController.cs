using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Demo1.DataAccessLogic;
using Demo1.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Demo1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValueController : ControllerBase
    {
        private readonly ValueRepo _repo;
        public ValueController(ValueRepo repo)
        {
            _repo = repo ?? throw new ArgumentNullException(nameof(repo));
        }
        //GET api/value
        [HttpGet]
        public async Task<List<Value>> Get()
        {
            return await _repo.GetAll();
        }
        //GET api/value/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Value>> Get(int Id)
        {
            var response = await _repo.GetById(Id);
            if (response == null)
            {
                return NotFound();
            }
            return response;
        }
        //POST api/value
        [HttpPost]
        public async Task Post([FromBody] Value value)
        {
            await _repo.Insert(value);
        }
        //DELETE api/value/5
        [HttpDelete("{id}")]
        public async Task Delete(int Id)
        {
            await _repo.DeleteById(Id);
        }
    }
}
