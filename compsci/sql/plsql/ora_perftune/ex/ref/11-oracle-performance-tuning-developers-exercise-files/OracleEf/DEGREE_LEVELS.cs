//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace OracleEf
{
    using System;
    using System.Collections.Generic;
    
    public partial class DEGREE_LEVELS
    {
        public DEGREE_LEVELS()
        {
            this.CLASS_STANDINGS = new HashSet<CLASS_STANDINGS>();
            this.DEGREE_TYPES = new HashSet<DEGREE_TYPES>();
        }
    
        public string DEGREE_LEVEL_CODE { get; set; }
        public string DEGREE_LEVEL_NAME { get; set; }
    
        public virtual ICollection<CLASS_STANDINGS> CLASS_STANDINGS { get; set; }
        public virtual ICollection<DEGREE_TYPES> DEGREE_TYPES { get; set; }
    }
}
