using System;

namespace Optimizer
{
    internal static class ToggleCompatibility
    {
        internal static string GetBlockReason(int build, string controlName)
        {
            if (build <= 0)
                return "The Windows build could not be detected. The adjustment was skipped.";

            // Gate both directions until the inherited handlers are verified on these builds.
            if (build < 26200)
                return null;

            switch (controlName)
            {
                case "homegroupSw":
                    return "HomeGroup was removed from Windows. Its legacy services cannot be configured.";
                case "chatSw":
                    return "This adjustment targets the retired Chat taskbar integration.";
                default:
                    return string.Format("This adjustment is pending validation on Windows build {0}.", build);
            }
        }
    }
}
