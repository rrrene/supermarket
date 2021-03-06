class CookbookVersionsController < ApplicationController
  #
  # GET /cookbooks/:cookbook_id/versions/:version
  #
  # Redirects the user to the cookbook artifact
  #
  def download
    cookbook = Cookbook.with_name(params[:cookbook_id]).first!
    version = cookbook.get_version!(params[:version])
    CookbookVersion.increment_counter(:download_count, version.id)
    Cookbook.increment_counter(:download_count, cookbook.id)

    SegmentIO.track_server_event(
      'cookbook_version_downloaded',
      cookbook: cookbook.name,
      version: version.version
    )

    redirect_to version.tarball.url
  end
end
