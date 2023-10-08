using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace SIS.OpenCore.Server.Data.Model.Config
{
	public partial class RoleConfiguration : IEntityTypeConfiguration<IdentityRole>
	{
		public void Configure(EntityTypeBuilder<IdentityRole> builder)
		{
			//builder.HasData(
			//	new IdentityRole
			//	{
			//		Id = "1",
			//		Name = RoleType.Doctor.ToString(),
			//		NormalizedName = RoleType.Doctor.ToString()
			//	},
			//	new IdentityRole
			//	{
			//		Id = "2",
			//		Name = RoleType.Patient.ToString(),
			//		NormalizedName = RoleType.Patient.ToString()
			//	},
			//	new IdentityRole
			//	{
			//		Id = "3",
			//		Name = RoleType.DoctorRecipient.ToString(),
			//		NormalizedName = RoleType.DoctorRecipient.ToString()
			//	}
			//);
		}
	}
}
