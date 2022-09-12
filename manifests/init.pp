# @summary Allow to create packages resources in Hiera without creating a dedicated class or profile
#
# @example
#   include packages
class packages (
  Optional[String] $merge_behavior = undef,
) {
  # Search the packages definition in Hiera
  $packages = lookup('packages', Hash[String,Variant[Undef,Hash[String,Any]]], $merge_behavior, {})

  # For each package
  $packages.each |String $pkg_name, Variant[Undef,Hash] $contentVariant| {
    if ($contentVariant =~ Hash) {
      $content = $contentVariant
    }
    else {
      $content = {}
    }

    # Allow the possibility to ignore a package from Hiera (useful with a definition in Hiera and in a class)
    if !('ensure' in $content) or $content['ensure'] != "ignore" {
      # Detect the provider and add it the the title of the created ressource
      if 'provider' in $content {
        $provider = "@${content['provider']}"
      }
      else {
        $provider = ''
      }

      create_resources("package", { "hiera/${pkg_name}${provider}" => $content + {'name' => $pkg_name} })
    }
  }
}
