# cloud-collab-docker

[Docker][docker] image to support collaboration (e.g., pair programming) in the cloud using [Floobits][floobits].

The easiest way to get up and running is probably [Tutum][tutum] (see below).

## Getting Started

First, you'll need to create an account at [Floobits][floobits]. Then, you'll need to go to the settings tab within the Floobits site and make a note of your `api_key`, `secret`, and `username` contained within your `.floorc.json` file. In addition, you'll need to decide on a Floobits workspace URL that you want to use, typically of the form:

`https://floobits.com/<USER_OR_ORG_NAME>/<WORKSPACE_NAME>`

### Running Locally

Edit `docker-compose.yml` (**don't commit your changes!!!**) to match your Floobits username and desired workspace name, then:

```bash
$ docker-compose up
```

Then visit `https://floobits.com/<USER_OR_ORG_NAME>/<WORKSPACE_NAME>` in your browser.

### Running in the Cloud (via Tutum)

First, you'll need to create a [Tutum][tutum] account via [Docker][docker]. You'll need to ensure that your account is hooked up to [Digital Ocean][digitalocean], [AWS][aws], or some other cloud provider.

#### Quick and Dirty

 Once your account is set up, you should be able to deploy using the button below. You'll have to edit the "stack file" on Tutum with the correct environment variable values to match your Floobits info.

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)

#### Recommended Approach

1. Install the [Tutum CLI][tutum-cli]: `brew install tutum`
2. Set your `TUTUM_USER` and `TUTUM_APIKEY` environment variables.
3. Create a `tutum.yaml` file (based on the `docker-compose.yaml` file.
4. Deploy:

    ```bash
    $ tutum up -f tutum.yaml
    ```


## Notes

- This image installs includes workable Ruby and Node.js environments. It would probably be better to break this into multiple images.
- See also: [cloud-collab-docker on Docker Hub][cloud-collab-docker-dockerhub]


## License

[ISC][isc-license]


<!-- references -->
[docker]:https://www.docker.com/
[floobits]:https://floobits.com/
[tutum]:https://tutum.co/
[digitalocean]:https://www.digitalocean.com/
[aws]:https://aws.amazon.com/
[tutum-cli]:https://github.com/tutumcloud/cli
[cloud-collab-docker-dockerhub]:https://hub.docker.com/r/learnersguild/cloud-collab-docker/
[isc-license]:http://choosealicense.com/licenses/isc/
