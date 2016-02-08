using System.Web;
using System.Web.Optimization;

namespace CMI.Track.Web
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/lib/jquery/jquery.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/lib/jquery.validate/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/lib/modernizr-*"));
              
            bundles.Add(new ScriptBundle("~/bundles/Logon").Include(                
                "~/Scripts/lib/jquery/jquery.js",
                "~/Scripts/lib/jquery.validate/jquery.validate*",
                "~/Scripts/lib/bower_components/bootstrap/dist/js/bootstrap.js",
                "~/Scripts/lib/bower_components/metisMenu/dist/metisMenu.min.js",
                "~/Scripts/lib/sb-admin-2.js"
                ));

              bundles.Add(new StyleBundle("~/Content/cssLogon").Include(
                      "~/Scripts/lib/bower_components/bootstrap/dist/css/bootstrap.css",
                      "~/Scripts/lib/bower_components/metisMenu/dist/metisMenu.min.css",
                      "~/Scripts/lib/bower_components/font-awesome/css/font-awesome.min.css",                     
                      "~/Content/site.css"                      
                      ));

            bundles.Add(new ScriptBundle("~/bundles/general").Include(
                   "~/Scripts/lib/bower_components/bootstrap/dist/js/bootstrap.js",
                   "~/Scripts/lib/underscore/underscore.js",
                   "~/Scripts/lib/backbone/backbone.js",
                   "~/Scripts/lib/bbGrid.js",                                          
                   "~/Scripts/lib/bower_components/metisMenu/dist/metisMenu.js",
                   "~/Scripts/lib/sb-admin.js",
                   "~/Scripts/lib/modernizr-2.6.2.js",
                   "~/Scripts/_Principal.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Scripts/lib/bower_components/bootstrap/dist/css/bootstrap.css",
                       "~/Scripts/lib/bower_components/metisMenu/dist/metisMenu.min.css",
                      "~/Scripts/lib/bower_components/font-awesome/css/font-awesome.min.css",
                      "~/Content/bbGrid.css",
                      "~/Content/site.css"));
        }
    }
}