using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ConferenceWebSite.Startup))]
namespace ConferenceWebSite
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
