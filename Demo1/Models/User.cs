using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

using Demo1.CustomValidation;
namespace Demo1.Models
{
    public class User
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string FullName { get; set; }
        //[Required]
        //[RoleValidate(Allowed=new string[] { "Admin","User"},ErrorMessage="Role Invalid")]
        public string Role { get; set; }

    }
}
