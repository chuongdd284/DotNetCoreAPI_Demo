using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Demo1.DataAccessLogic;
using Demo1.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.VisualBasic;

namespace Demo1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        /*public IConfiguration Configuration { get; }
        public UserController(IConfiguration configuration)
        {
            Configuration = configuration;
        }*/

        //initiate a DAL
        //DAL db = new DAL();

        private readonly UserRepo _repo;
        public UserController(UserRepo repo)
        {
            this._repo = repo ?? throw new ArgumentNullException(nameof(repo));
        }
        //GET api/User
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> Get()
        {
            return await _repo.GetAll();
        }
        
        //GET api/User/5
        //[Route("api/[controller]/{Id}")]
        [HttpGet("{Id:int}")]
        //[HttpGet("{Id}")]
        public async Task<ActionResult<User>> Get(int Id)
        {
            var response = await _repo.GetById(Id);
            if (response == null)
            {
                return NotFound();
            }
            return response;
        }

        //[HttpGet]
        //[Route("Role")]
        [HttpGet("{Role}")]
        public async Task<ActionResult<IEnumerable<User>>> Get(string Role)
        {
            var response = await _repo.GetUsersByRole(Role);
            if (response == null)
            {
                return NotFound();
            }
            return response;
        }
            //GET: api/User/search
            /*[HttpGet("Search")]
            public async Task<ActionResult<IEnumerable<User>>> SearchByUserName([FromQuery] string Name)
            {
                var response = await _repo.SearchByUserName(Name);
                if (response == null)
                {
                    return NotFound();
                }
                return response;
            }*/
        
        //POST: api/User/
        [HttpPost]
        public async Task Post([FromBody] User user)
        {
            await _repo.InsertUser(user);
        }
        //PUT: api/User
        [HttpPut("{Id}")]
        //public void Put(int Id, [FromBody] string value)
        public async Task Update(int Id, [FromBody] User user)
        {
            await _repo.Update(Id, user);
        }

        //DELETE api/User/5
        [HttpDelete("{Id}")]
        public async Task Delete(int Id)
        {
            await _repo.DeleteById(Id);
        }
    }
}
