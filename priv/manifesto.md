# Manifesto for local AI

*This page is a rant. It was written in anger at the continued
propaganda — the edge is deliberate; the curse words were left at the
door.*

## The cave

People who have been using cloud frontier models exclusively for the
past one and a half or two years have a very distorted view of what is
now possible with local AI models. They have not spent the time to
update their knowledge on what is really possible, and to what extent.
Not all of them — but many, I would argue most, are caught in Plato's
allegorical cave, taking shadows on the wall for the world. If you want
to understand why I keep saying that, read
[The Cave](https://overbring.com/books/cave/) — an exploration of the
allegory for incumbents, and for the serious contenders against them.

I keep meeting people who think the only way to use AI to get things
done is the latest cloud model at an immense monthly cost — even for
totally basic things that models of last year could do. Especially for
agentic coding there is a large misunderstanding that the only way to
get working code is a cloud model by whatever name it has this month,
and that anything else is wasting time. Beyond the privacy issues and
the non-sovereign approach of those providers, they waste time in a
quieter way too: a cloud model eating through millions of tokens — your
plan's usage — for something that, while you do other work, a local
model on your own hardware could finish. No data sent to a cloud
provider for training. No proprietary information or IP leaking.
Sometimes the job is done with a single prompt — which is where the
trick of prompting, and the skill of the operator, comes in.

## The one-shot benchmark is a lie

The stupid approach to evaluating whether a model is good enough for
coding is the one-shot prompt. *"Build me this video game"* — totally
underspecified, no requirements, no explanation of what it should look
like or how it should work. Just build me a clone of that popular
game. If the game you intend to clone is popular, then with such a
poor prompt — one that contains absolutely no operator knowledge, where
you are merely a meat proxy — the only thing you are evaluating is
whether the model has already seen enough of that game during training
to regurgitate what you asked, with or without a different look. You
are not benchmarking coding ability. You are paying dearly for the
world knowledge of a trillion-plus-parameter model, regurgitating
something of no value.

## The driver's seat

The real value of local AI is using it as an experienced collaborator
and guide, with you in the driver's seat. It does not matter whether a
model like Qwen 3.8-27B can deliver a clone of this game from a crappy
short one-shot prompt. What matters is evaluating the model on its
ability to work *with you* across many rounds — even though it takes
longer, because it runs on budget hardware — so that you develop
something that genuinely solves an engineering problem.

In this codebase the game is not as important as the stuff around it:
the lobby, the leaderboard, being able to spectate any user's game
live — Phoenix LiveView, WebSockets, PubSub — and the ability to replay
any game. That is where you are actually evaluating the model's
decisions: its competency in making good architectural decisions, with
or without your nudge, so that it builds the entire system
architecture starting from a pretty well-specified prompt.

## Requirements, not vibes

Real-world usage of local AI models is not *"hey, build me a clone of
this software."* It is a deliberate, systematic approach that requires
requirements engineering and systems architecture, so that you
actually build a system that works and delivers on both functional and
non-functional requirements. That is the approach, albeit in a
lightweight manner, taken here.

## This is the rebuttal

This codebase was built as a proof, and a rebuttal, against someone on
LinkedIn who claimed that Qwen 3.8-27B cannot code, cannot develop
proper code, and is generally no match for frontier models. Maybe not
in speed. But since at least May — even with Qwen 3.6 — and since
August with Qwen 3.8, I have been developing multiple codebases with me
in the driver's seat: requirements, specification, architecture, and
building something that gets work done — instead of hoping that the
model can read my mind.

This codebase was developed entirely by Qwen 3.8-27B. I did not touch a
single line of code. And it was done in anger at the continued
propaganda of the fanboys of Claude, Astra, whatever the frontier
model is called this month — the one with multiple trillion parameters
that can do wonders at high cost, and which most people use,
paradoxically, for work that by far does not require that kind of
capability or cost.

## You are the product

Vibe coders are welcome to keep paying their super-expensive monthly
subscriptions — the ones that keep getting encrusted, delivering less
and less — and to remain serfs of the cloud providers. They can stay in
the cave that the providers built for them and keep believing that the
incredibly expensive model is the only way to get value out of AI.
Actual experience proves that you do not need the latest and greatest
model at $5 per million tokens of input and $10–25 per million of
output to build well-designed, functional, requirements-fulfilling
software that delivers value to customers and users.

And to be clear about what you are buying: your data goes to the
provider for training. Your proprietary information, your IP, goes
there too. You are not merely the customer. You are the product — and
the product-improver: paying tribute to a cloud despot, so that you
keep paying, on work that a local model and a bit more human
involvement could do competently.

This is no different from buying a very expensive BMW, Mercedes, or
Audi and, because you pay a lot, convincing yourself that it is the
pinnacle of automotive. That is Veblen pricing, and it has a name:
people who should know better thinking that the only way to benefit
from AI is to pay through the nose.

## The Windows 95 moment

A little over thirty years ago there was a big-bang moment in the
history of personal computing: the release of Windows 95. Within
months — a year, pretty much — virtually every home in the advanced
economies had a computer running it. That democratization shaped the
world we live in.

Since then the world of personal computing has *regressed*: operating
systems that snoop on you; vendors who handicap their own hardware
through firmware updates — what has been proven with the tensor
calculation performance of the RTX 40 series, and claimed for DLSS on
30-series GPUs. People no longer know their history; young generations
do not even have a concept of a personal computer — one that holds
your own data, does not send it to a cloud, and where the personal
responsibility of backing up and archiving that data goes hand in hand
with sovereignty, instead of serfdom to a digital overlord.

## The cat is out of the bag

We are at a crossroads. A few entrenched — and not particularly
profitable — companies, in cahoots with each other and with captured
regulators, are trying to claim the next step of productivity
evolution: personal and business, the competitive advantage of big and
small companies alike. They pretend that open-weights models are
dangerous, that you can never know whether your data will leak, that
a model might touch things it should not, that open models represent a
danger to mankind, or that their own models are so capable that a
Skynet-like scenario is bound to happen. All of it: self-serving
arguments to prop up their IPO prices.

The more people believe those lies, the more we delay the Windows 95
moment of local AI.

So, to them, my prediction, first of all: you can ban whatever you
want. Since I have GPUs, and the model weights are downloaded and
backed up across three different disks, you will never pry local AI
from my hands. Stop releasing models, ban GPU sales, do whatever you
want. **The cat is out of the bag. Deal with it.**

Local AI models are capable. All of the good ones — most of the good
ones — are coming from China, because China is playing exactly to the
weakness that the greed of the incumbents is displaying through their
behavior: trying to get the US government to nationalize part of their
business so that their revenue projections can ever hold water.
Anyone who already owns compute capacity — or is willing to go out and
buy a single 12 GB or 16 GB graphics card — already has their card out
of the bag.

## Who wins

The question that matters, from a civilizational perspective, is
whether we let a couple of companies in cahoots with each other seize
the next step of productivity evolution. My bet is on the small
companies — like mine.

The few of the frontier-model fanboys who have at some point tried
local AI mostly deride local models as too slow, or not smart enough.
What I have figured out after talking to them is that they have no
idea how to use any tool. They are lazy vibe coders, and they think
the model can somehow read their mind. They are doomed to become
redundant meat proxies: wishing that a model will translate a wish
into proper requirements, specification, architecture, and even
figure out the trade-offs — those people are making themselves
redundant.

Those of us who have invested in compute infrastructure — whether we
bought it early and cheap, or are buying it now in a rush just to
build a new capability — who want to keep learning and do not pretend
that development does not require the management of knowledge gaps,
hypotheses, and the active work on the basis of increasingly solid
information: **those of us will win.**

## Knowledge is the deliverable

Because part of the work done here delivers *knowledge* — and
knowledge is a prime deliverable next to a working artifact. Whether
it is code that compiles and works correctly, or decision support, or
an analysis, or a ledger of the payments in your bank account, or a
summary of a document, or a learning agent that helps you learn
something by acting as a Socratic tutor — it does not matter what you
want to do. The thing that matters is having clarity of what it is
that you want to achieve.

---

*This codebase was created in anger and in annoyance, at all those who
pretend that local AI is limiting, or that it cannot do things
competently. As a proof that yes — you can build things — if you are
not an idiot about it.*
