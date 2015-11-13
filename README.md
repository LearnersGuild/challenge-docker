# cloud-collab-docker

[Docker][docker] image to support collaboration (e.g., pair programming) in the cloud using [Floobits][floobits].

The easiest way to get up and running is probably [Tutum][tutum] (see below).

## Getting Started

First, you'll need to create an account at [Floobits][floobits]. Then, you'll need to go to the settings tab within the Floobits site and grab a copy of your `.floorc.json` file and copy it to this folder. Don't worry, it's ignored via `.gitignore`.

### Running Locally

Edit `docker-compose.yml` to match your Floobits username and desired workspace name, then:

```bash
$ docker-compose up
```

Then visit `https://floobits.com/<FLOOBITS_USER>/<FLOOBITS_WORKSPACE>` in your browser.

### Running in the Cloud (via Tutum)

First, you'll need to create a [Tutum][tutum] account via [Docker][docker]. You'll need to ensure that your account is hooked up to [Digital Ocean][digitalocean], [AWS][aws], or some other cloud provider. At that point, you should be able to deploy using the button below. You'll have to edit the "stack file" on Tutum with the correct environment to atch your Floobits.

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)



## Notes

- This image installs includes workable Ruby and Node.js environments. It would probably be better to break this into multiple images.


<!-- references -->
[docker]:https://www.docker.com/
[floobits]:https://floobits.com/
[tutum]:https://tutum.co/
[digitalocean]:https://www.digitalocean.com/
[aws]:https://aws.amazon.com/
