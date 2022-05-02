# ManageIQ Spaces Purger

The spaces purger is a tool to keep our DigitalOcean Spaces account at a
reasonable size by regularly purging old images from releases.manageiq.org.

## Usage

```sh
$ SPACES_BUCKET=<bucket_name> SPACES_KEY=<access_key> SPACES_SECRET=<access_secret> bin/digital_ocean_spaces_cleanup.rb
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
