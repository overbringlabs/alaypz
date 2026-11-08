In my experience, people who have spent the last year and a half
talking only to cloud frontier models have a badly distorted picture
of what is possible on a machine you own. They have not spent the
time to update their knowledge. Not all of them — but many, I would
argue most, are still in Plato's cave, taking shadows on the wall for
the world. If you want the longer form of that allegory, for
incumbents and for the people trying to unseat them, it is in
[The Cave](https://overbring.com/books/cave/).

This is about the next step of personal computing, who gets to own
it, and what it takes to use it without turning yourself into a
machine operator.

## The Windows 95 moment is already here

A little over thirty years ago there was a big-bang moment in
personal computing: Windows 95. Within months — a year, pretty much —
homes in the advanced economies had a computer running it. That
democratization of *personal* compute shaped the world we live in.

Since then the world of personal computing has *regressed*. Operating
systems that snoop on you. Vendors who handicap their own hardware
through firmware. Young people who barely have a concept of a
personal computer: a machine that holds *your* data, does not send it
to a cloud, and where backing it up is your job, not a subscription.
I wrote about that regression when Microsoft's Copilot+ line tried to
turn the PC into a listening post —
[the death knell of the Personal Computer](https://overbring.com/blog/2024-05-22-the-death-knell-of-personal-computing/)
was not a metaphor.

We are at the next such moment. Not because a 5090 magically appeared
on every desk. Because the *capability* crossed a line.

Hardware for this is not great. It is also not disastrous. A single
12 GB or 16 GB card, or two of them, already runs work that people
currently pay twenty, fifty, a hundred, two hundred dollars a month
to get from a vendor — plus the tribute of whatever they typed. Open
weights in the 27-billion-parameter class, and Mixture-of-Experts
models in the 35-billion class with a handful of billions active per
token, do real work on that hardware today. Fine-tunes of those
families do too. I have been building with them since the spring, on
budget cards, on machines that answer only to me.

That is the existence proof. The next open-weights generation —
whatever it is called; people are already claiming another
breakthrough — will move the line again. So will a less miserable
user experience around standing a machine up. So will the eventual
downward correction in RAM and GPU prices. Waiting for the perfect
box is opportunity cost. In a year or two it will be cheaper again
to buy the hardware. It is already cheap enough to start.

The sentence I want in ordinary speech is not "I have a Claude
subscription." It is *"we have local AI at home"* — the way people
once said *"we have a Windows 95 PC at home."* Inference capacity
you own. Personal AI. As commonplace, among people who can afford it
and want it, as personal computing became in the nineties.

The more people stay in the cave, the longer that sentence is delayed.

## What that actually enables

The point is not a chatbot that lives in a tab. The point is a
machine that does work *you* would otherwise do, or pay a stranger's
computer to do, without the stranger.

For a private person: bank statements and reminders. Integration
with the phone. Keeping track of things. The smart home. A tutor
that will sit with you on a subject and never ship the question to a
vendor's training set. Asking something of a personal nature —
health, money, a family mess — without it becoming someone else's
dataset. Reconciling the mess of notes and emails that is a life.

For a business: getting rid of bureaucratic paper. Checking email
and aligning spreadsheets and notes. End-to-end flows that today eat
a human's week — an RFQ, an offer, a delivery schedule, a chase when
the invoice has not gone out. A 24/7 work associate, or more than
one, on machines that answer only to the firm. I run a trading
business this way. Market knowledge, prices, and customer data stay
inside the building. That is not a policy document. That is the
setup.

The best future I can see is the one in which personal AI is as
ordinary as personal computing was, for the people who want it. Not
Claude versus this week's other name. Ownership of the next
productivity step. Individuals and small companies keeping the
gains, instead of renting them back from a handful of firms that are
already not particularly profitable and already in cahoots with
captured regulators.

That future is better. It is also annoying to watch people argue it
away.

## Why people stay in the cave

I keep meeting people who think the only way to use AI is the latest
cloud model at an immense monthly cost — even for work that last
year's weights could do. Especially for coding, there is a large
misunderstanding that the only way to get working software is
whatever frontier name is fashionable this month, and that anything
else is wasting time.

They are not all stupid. They are caught. The mechanisms are old.

**Identity.** People attach their name to the latest sexiest fad —
Claude Code, the frontier model of the month — the way they attached
it to a blue bubble on a phone. They do not need the thing. The name
*is* the product. I have watched this with Microsoft, with Apple,
with every incumbent that learned to sell belonging. The cave is
comfortable if the herd is in it.

**Cover your ass.** Corporates go with the obvious overpriced
solution because otherwise they look like laggards, or like they are
rocking the boat. I spent a decade watching this movie under other
titles: Lean, Agile, SAFe, "AI strategy" slide decks from a firm
that will happily bill for executive absolution. [The Incredible
Story of Deft](https://overbring.com/books/deft/) is that movie as a
novel. [Lo and Behold, X!](https://overbring.com/books/lo-and-behold-x/)
is the same movie as a decade in a kingdom. Miracle-cure frameworks.
Alluring narratives of success at organizations that do not look
like yours. Passionate experts. The current AI hype is Deft in a new
cloth.

**Veblen pricing.** You buy a very expensive German car and, because
you paid a lot, you convince yourself it is the pinnacle of
automotive. Cloud AI has the same structure. Twenty dollars, fifty,
a hundred, two hundred a month, and rising, for the *privilege* of
sending private data to a vendor. Cache hits, cache misses, price
per million tokens of input and output — a meter on a hose you do
not own. Subscriptions get encrusted. Usage pools shrink. Serving
quietly gets cheaper for them and dumber for you, and you cannot
choose the quant. Locally you pick the trade-off yourself.

**You are the product.** Your data goes to the provider for
training. Your proprietary information, your IP, goes there too. You
are not merely the customer. You are the product, and the
product-improver: paying tribute so that you keep paying, on work
that a local model and a bit more human involvement could do. I
would rather discuss a personal matter with a machine in the next
room than with a black box whose job, in part, is to get better at
the next customer using my sentence.

**Fear, dressed as safety.** A few entrenched companies, with
captured regulators, are trying to claim the next productivity step
as theirs. They pretend open-weights models are dangerous, that you
can never know whether your data will leak, that a model might touch
things it should not, that open models are a danger to mankind, or
that their own models are so capable that a Skynet-like scenario is
bound to happen. All of it: self-serving arguments to prop up IPO
prices.

You can ban whatever you want. I have GPUs. The weights are
downloaded and backed up across three disks. You will never pry
local AI from my hands. Stop releasing models, ban GPU sales, do
whatever you want. **The cat is out of the bag. Deal with it.**

Most of the good open weights are coming from China, because China
is playing exactly to the weakness the incumbents are displaying:
trying to get a government to nationalize part of the business so
the revenue projections hold water. Anyone who already owns compute
— or is willing to buy a single 12 GB or 16 GB card — already has
their card out of the bag.

## A tool is only half the story

Here is the part that is easy to skip if you only want to win an
argument about cloud versus local.

A tool is only half the story. The other half is competence in using
it. That is true of a lathe, a CAD suite, a frontier model, and a
local one. If you underspecify, if you cannot think the problem into
pieces, if you treat the model as a black box that will magically
fulfil a wish — you are not evaluating the model. You are evaluating
your absence.

I learned this the expensive way, twice.

Once in 2008, as a turbine engineer, shoveling designs between CAD
and overnight CFD jobs, waiting eighteen hours to find out a variant
was junk. A colleague wanted a vendor's "pushbutton optimization"
suite: lean back, pretty graphs, per-core licenses humming. It never
left his team. What worked was the boring version: me in the loop,
low-fidelity first, kill bad regions of the design space, spend the
expensive hours only on what deserved them. I got faster *and*
smarter. The fully automated path turned a trained engineer into a
machine operator. I wrote the long version of that parallel in
[Vibe coding leaves me with a very sour
taste](https://overbring.com/blog/2025-08-16-vibe-coding-sour-taste/).
The punchline has not aged: *spend more tokens, you peasants* is the
same joke as *calculate more, you peasants*.

The second time was vibe coding itself. Underspecified one-shots.
"Build me a clone of that popular game." If the game is popular, you
are measuring how much of the training data you are paying to get
regurgitated. The operator is a meat proxy. You are not
benchmarking coding ability. You are paying dearly for world
knowledge. YouTube is full of this, because it films well.

Real use is not that. It is a collaborator, with you in the driver's
seat: requirements, specification, architecture, many rounds. The
model does not read your mind. You have to know what you are asking
for well enough to notice when the answer is wrong.

That is engineering. It is not a job title.

[The exceptionalism of software is
unwarranted](https://overbring.com/blog/2025-09-06-software-engineering-vs-other-engineering/).
Software is different — mutability, cost of change, physics
abstracted away — but not *that* different. Coding is
implementation, the way a CAD drawing is implementation. Engineering
is trade-offs, architecture, failure modes, non-functionals,
accountability for the system. [Everyone is an engineer in software
(allegedly)](https://overbring.com/blog/2026-05-27-everyone-is-an-engineer-now-allegedly/)
is about what happens when you hand the word out like candy and then
wonder why the building is fragile.

I am not claiming everything deserves engineering. A mock does not.
An MVP often does not. Plenty of things do, if they are supposed to
still work in two years. For those, staffing the work with people
who will not own the problem is how you get a backlog of missing
understanding.

The human's job, with any of these models, is the job it always was:

- Own the problem. If you cannot explain it so another person would
  understand, the deficit is older than this technology. I said that
  in 2023, when LinkedIn was wailing about a shortage of "skilled LLM
  users" —
  [it was not a skills shortage in GenAI](https://overbring.com/blog/2023-06-02-oh-no-we-have-no-skilled-llm-users/).
- Break it into pieces. Knowledge gaps, hypotheses, a spec that
  constrains without encoding the answer. Rambling into a microphone
  can *open* a problem. It does not replace owning it.
- Review. A fool with a tool is still a fool, even if the tool is
  cool and makes the vendor drool. Stay in the zone where you know
  enough to smell nonsense —
  [the 2×2 I still use](https://overbring.com/articles/2023-06-23-on-using-llm-to-get-things-done/).
- Keep the knowledge. Institutional memory that accumulates: how
  this codebase does a thing, the skill you extracted because you
  did it twice, the cookbook, the ledger. You pay for that once.
  Scatter, hand-off, and wishful thinking are still the three
  wastes. Compaction is a hand-off you do not control.

Local models do not forgive incompetence. They expose it, because
there is no trillion-parameter world-knowledge crutch to hide
behind. That is a feature. The people who will get value out of this
are the people who were already trying to understand the system.

Separating "the brains" from "the hands" is a managerial fantasy. I
have never seen it produce a shared picture of the work. Meraki and
craftsmanship eat the process for breakfast; they always did.

## Who wins

The civilizational question is whether we let a couple of companies
seize the next productivity step. My bet is on the small ones —
like mine.

The frontier-model fanboys who have tried local AI mostly deride it
as too slow, or not smart enough. What I have figured out after
talking to them is that many of them have no idea how to use any
tool. They want the model to translate a wish into requirements,
specification, architecture, and the trade-offs. Those people are
making themselves redundant meat proxies. Cloud or local, the
dynamic is the same. Local just makes the invoice honest.

Those of us who have invested in compute — bought it early, or
bought it in a rush — who want to keep learning, and who do not
pretend that development does not require managing knowledge gaps:
**those of us will win.**

Knowledge is a deliverable, next to a working artifact. Code that
compiles. A decision. A ledger of payments. A summary of a document.
A tutor. It does not matter what you want to do. What matters is
clarity about what you are trying to achieve, on a machine that
belongs to you.

The better future is not a more expensive monthly plan. It is
personal AI as ordinary as a PC in 1996, used by people who still
know how to think.
