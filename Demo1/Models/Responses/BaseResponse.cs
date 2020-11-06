using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Demo1.Models.Responses
{
    public class BaseResponse
    {
        public int errorCode { get; set; }
        public string message { get; set; }

        public object data { get; set; }
    }
}
