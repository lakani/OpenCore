using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;

namespace SIS.OpenCore.Server.Data.Config
{
	public partial class UserDataConfig : IEntityTypeConfiguration<BaseUserData>
	{
		public void Configure(EntityTypeBuilder<BaseUserData> builder)
		{
			// this should not be called
			throw new NotImplementedException();
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			//#region mandatory or not 
			//builder.HasKey(p => new { p.ID });
			//builder.Property(p => p.ID).IsRequired();
			//builder.Property(p => p.ID).ValueGeneratedOnAdd();
			//builder.Property(p => p.Name).IsRequired();
			//builder.Property(p => p.Name).HasMaxLength(50);
			//#endregion
		}

		public void Configure(EntityTypeBuilder<Zone> builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			#endregion
		}

		public void Configure(EntityTypeBuilder<Dep> builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			#endregion
		}

		
		public void Configure(EntityTypeBuilder<Sector> builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			#endregion
		}

		public void Configure(EntityTypeBuilder<Unit> builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			
			#endregion
		}


		public void Configure(EntityTypeBuilder<Company > builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			#endregion
		}

		public void Configure(EntityTypeBuilder<Branch> builder)
		{
			// the below seems to be mandatory but not mandatory to speed things up, what do you thing ???
			#region mandatory or not 
			builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
			//builder.Property(p => p.CompanyNo).IsRequired();
			#endregion
		}
	}
}
