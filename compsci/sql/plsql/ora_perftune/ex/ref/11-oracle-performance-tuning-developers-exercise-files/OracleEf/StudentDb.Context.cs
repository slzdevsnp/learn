﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class StudentDb : DbContext
    {
        public StudentDb()
            : base("name=StudentDb")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<APPLICATION> APPLICATIONS { get; set; }
        public DbSet<CLASS_STANDINGS> CLASS_STANDINGS { get; set; }
        public DbSet<COURSE_ENROLLMENTS> COURSE_ENROLLMENTS { get; set; }
        public DbSet<COURSE_OFFERINGS> COURSE_OFFERINGS { get; set; }
        public DbSet<COURS> COURSES { get; set; }
        public DbSet<DEGREE_LEVELS> DEGREE_LEVELS { get; set; }
        public DbSet<DEGREE_REQUIREMENTS> DEGREE_REQUIREMENTS { get; set; }
        public DbSet<DEGREE_TYPES> DEGREE_TYPES { get; set; }
        public DbSet<DEGREE> DEGREES { get; set; }
        public DbSet<DEPARTMENT> DEPARTMENTS { get; set; }
        public DbSet<GRADE> GRADES { get; set; }
        public DbSet<SESSION> SESSIONS { get; set; }
        public DbSet<STUDENT> STUDENTS { get; set; }
        public DbSet<TERM> TERMS { get; set; }
    }
}
