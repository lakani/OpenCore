using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Identity;
using SIS.OpenCore.Shared.Model.Common;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices.Protocols;
using SIS.OpenCore.Shared.Model.Objects.UserData;

#nullable enable

namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
    [Route("v1/api/OpenCore/system/Identity/Account/auth/[action]")]
    public class AuthenticationController : ControllerBase
    {
        private readonly ILogger<AuthenticationController> _logger;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly UserManager<ApplicationUser> _userManager;

        public AuthenticationController(
            ILogger<AuthenticationController> logger,
            SignInManager<ApplicationUser> signInManager,
            UserManager<ApplicationUser> userManager)
        {
            _logger = logger;
            _signInManager = signInManager;
            _userManager = userManager;
            _logger.Log(LogLevel.Information, "AuthenticationController() : constructor");
        }

        [HttpGet(Name ="ADLogin")]
        public ActionResult ADLogin(string domain, string username, string password)
        {
            try
            {
                using (var ldapConnection = new LdapConnection(domain))
                {
                    ldapConnection.Credential = new System.Net.NetworkCredential(username, password, domain);
                    ldapConnection.AuthType = AuthType.Negotiate;
                    ldapConnection.Bind(); // Attempt to bind with the provided credentials
                    _logger.LogInformation("Valid");
                    return Ok(new { Message = "Login successful", Successful = true });
                }
            }
            catch (LdapException)
            {
                _logger.LogInformation("Invalid credentials");
                return BadRequest(new { Message = "Invalid login data", Successful = false });
            }
            catch (Exception ex)
            {
                _logger.LogInformation($"An error occurred: {ex.Message}");
                return BadRequest(new { Message = "Invalid login data", Successful = false });
            }
        }

        [HttpPost]
        public async Task<ActionResult> Login([FromBody] ApplicationUser loginUser)
        {
            if (loginUser == null || string.IsNullOrEmpty(loginUser.UserName) || string.IsNullOrEmpty(loginUser.PasswordHash))
                return BadRequest(new { Message = "Invalid login data", Successful = false });

            var user = await _userManager.FindByNameAsync(loginUser.UserName);
            if (user == null)
                return Unauthorized(new { Message = "User not found", Successful = false });

            var result = await _signInManager.CheckPasswordSignInAsync(user, loginUser.PasswordHash, false);
            if (result.Succeeded)
            {
                // You may want to generate a JWT or session here
                return Ok(new { Message = "Login successful", Successful = true });
            }
            else
            {
                return Unauthorized(new { Message = "Invalid credentials", Successful = false });
            }
        }

        [HttpPost]
        public async Task<ActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            return Ok(new { Message = "Logout successful", Successful = true });
        }
    }
}
