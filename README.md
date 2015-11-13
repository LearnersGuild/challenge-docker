# Cloud Collaboration [Docker][docker] Image (via [Floobits][floobits] and [Tutum][tutum])

This is not yet ready for public consumption. For one thing, it assumes that there is a `.floorc.json` file in the current folder (which there is not -- it can be copied from each user's home folder for now). We'll need to figure out a way to securely build this image in the long term.


## Getting Started

First, you'll need to create an account at [Floobits][floobits]. Then, you'll need to go to the settings tab within the Floobits site and grab a copy of your `.floorc.json` file and copy it to this folder. Don't worry, it's ignored via `.gitignore`.

### Running Locally

```bash
$ docker build -t learnersguild/cloud-collab-docker .
$ docker run -e "FLOOBITS_USER=<your Floobits username>"" "-e "FLOOBITS_WORKSPACE=<any string>" -dt learnersguild/cloud-collab-docker
```

Then visit `https://floobits.com/<FLOOBITS_USER>/<FLOOBITS_WORKSPACE>` in your browser.

### Running in the Cloud (via Tutum)

First, you'll need to create a [Tutum][tutum] account via [Docker][docker]. You'll need to ensure that your account is hooked up to [Digital Ocean][digitalocean], [AWS][aws], or some other cloud provider. At that point, you should be able to deploy using this button:

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)


## Notes

- This image installs includes workable Ruby and Node.js environments. It would probably be better to break this into multiple images.


<!-- references -->
[docker]:https://www.docker.com/
[floobits]:https://floobits.com/
[tutum]:https://tutum.co/
[digitalocean]:https://www.digitalocean.com/
[aws]:https://aws.amazon.com/
