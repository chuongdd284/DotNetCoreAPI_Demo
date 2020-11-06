using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Demo1.Models.Responses
{
    public class PagingInfo
    {
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public int TotalRecord { get; set; }
        public int TotalPages { get; set; }
    }
}
