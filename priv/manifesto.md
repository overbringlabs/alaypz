In my experience, people who have spent the last year and a half
talking only to cloud frontier models have a badly distorted picture
of what is possible on a machine you own. They have not spent the
time to update their knowledge. Not all of them — but many, I would
argue most, are still in Plato's cave, taking shadows on the wall for
the world. The longer form of that allegory, for incumbents and for
the people trying to unseat them, is
[The Cave](https://overbring.com/books/cave/).

I care about the next step of personal computing: who gets to own
it, and whether you use it as a collaborator or as a machine
operator.

## The Windows 95 moment is already here

A little over thirty years ago personal computing had a big-bang
moment: Windows 95. Within months — a year, pretty much — homes in
the advanced economies had a computer running it. That
democratization of *personal* compute shaped the world we live in.

Since then the world of personal computing has *regressed*.
Operating systems that snoop on you. Vendors who handicap their own
hardware through firmware. Young people who barely have a concept of
a personal computer: a machine that holds *your* data, does not send
it to a cloud, and where backing it up is your job, not a
subscription. I wrote about that regression when Microsoft's
Copilot+ line tried to turn the PC into a listening post —
[the death knell of the Personal Computer](https://overbring.com/blog/2024-05-22-the-death-knell-of-personal-computing/)
was not a metaphor.

We are at the next such moment because the *capability* crossed a
line, not because a 5090 magically appeared on every desk.

Hardware for this is not great, and it is also not disastrous. As of
late 2026, if you are not sitting on 64-plus gigabytes of expensive
DDR5, a gut reading of cost versus what you can actually run puts
**32 GB of VRAM** as the sweet spot, and **16 GB** as the floor that
already does real work. A single 12 GB or 16 GB card, or two of
them, already runs work that people currently pay twenty, fifty, a
hundred, two hundred dollars a month to get from a vendor — plus the
tribute of whatever they typed.

Right now, until the next open-weights jump lands (people are
already talking about Qwen 4 as if it were Christmas), the dense
model I keep coming back to on that hardware is **Qwen 3.8-27B**.
When I want speed more than that last notch of thoroughness, I reach
for **Ornith 1.5-35B-A3B**, a Mixture-of-Experts that spends a
handful of billions of parameters per token. Fine-tunes of those
families do real work too. I have been building with them since the
spring, on budget cards, on machines that answer only to me. I
bought a 4070 Super and a 4060 Ti in 2024 and 2025, sat on them
because I had no use case, then put them on one machine. Twenty-eight
gigabytes of VRAM. The silicon did not get smarter. The *models* did.
Capability of the cards stayed put; capability of what they can run
is in a different league from a year ago. That is what an
appreciating asset looks like when the software side is moving.

Eight gigabytes of VRAM is the new four. Fine for embeddings,
reranking, a small chat. Practically useless for serious agentic
work. My ThinkPad W520 from 2012 already had 32 GB of DDR3. There is
no physical law that says a PC in 2026 should be cost-capped at 16
or 32 GB of anything. Wafer capacity got yanked toward HBM for the
data-center boom, consumer DRAM and GPU memory went into a drought,
and the path bifurcated. That drought will not last forever. Two
years, three, five — ten is a joke, you cannot predict a year —
consumer machines will have 64 GB on a GPU the way 8 GB used to be
the flagship, and hundreds of gigabytes of system RAM will stop
being a data-center punchline. When prices and capacity resume
something like normal behaviour, the question is whether we already
handed the capability to a handful of landlords.

I want ordinary speech to sound like *"we have local AI at home"*,
the way people once said *"we have a Windows 95 PC at home."*
Inference capacity you own. Personal AI, as commonplace among people
who can afford it and want it as personal computing became in the
nineties. The more people stay in the cave, the longer that sentence
is delayed.

## What that actually enables

A chatbot in a tab is the least interesting version of this. The
interesting version is a machine that does work you would otherwise
do yourself, or pay a stranger's computer to do, without the
stranger.

For a private person, and for a family, that means bank statements
and reminders, integration with the phone, keeping track of things,
the smart home, a tutor that will sit with you on a subject and
never ship the question to a vendor's training set. Homework.
Learning a skill. Playing. Research. The same spread a Windows 95
PC had: games, the early internet, writing, figuring things out,
including things other people might scoff at. Asking something of a
personal nature — health, money, a family mess — without it becoming
someone else's dataset. Reconciling the mess of notes and emails
that is a life.

I have sat with a local model and pasted an email confrontation, or
described a situation between me and someone else, and asked where I
was making a mistake in communication, what rough edges that implied
about how I behave. Totally innocuous. I would not send that to a
cloud vendor. Not because I have something to hide. Because those
personal matters do not belong in somebody else's training set, and
I do not want Anthropic or OpenAI or xAI looking over my shoulder
while I think.

For a business: getting rid of bureaucratic paper. Checking email
and aligning spreadsheets and notes. Flows that today eat a human's
week — an RFQ, an offer, a delivery schedule, a chase when the
invoice has not gone out. Agents that update inventory by reading
invoices and delivery notes. Names, phones, customer and supplier
records: privately identifiable information that I do not want in a
fuzzy thing I do not control. I do not assume the vendor is
malicious. I assume they can get hacked, and I assume I cannot audit
what they keep. I run a trading business this way. Market knowledge,
prices, and customer data stay inside the building. That is the
setup, not a policy document.

The prize is ownership of the next productivity step: individuals
and small companies keeping the gains, instead of renting them back
from a handful of firms that are already not particularly profitable
and already in cahoots with captured regulators. Watching people
argue that future away is annoying.

## The trade-offs are real

Local AI is not "cloud, but free and private." You pay differently,
and you wait differently. Pretending otherwise is how you lose the
argument with someone who has a million-token window and a credit
card.

On 32 GB of VRAM you can hold a 256k-token context, which is
workable, and if you actually *use* that whole window you pay in
throughput. One session, maybe two, depending on how you split the
card into slots. Agentic flows — take this document, call an API or
an MCP tool, do something, call something else — want about 64k as a
floor, so a native 256k model gives you four slots if you are
disciplined, or two slots at 128k if you want a main and a
delegate. Two different models co-resident is a hassle. Swapping
models costs wall-clock: load time, then prefill of whatever the
previous session had built up. Cloud does not make you care about
any of that. You burn tokens, you spawn sub-agents, capacity is
their problem until the invoice arrives.

That is a genuine trade-off. For some work it is limiting. For a lot
of work it is just slower, which means you wait, which means you
have to be more deliberate: requirements, a nudge, a correction,
another task while it cranks. Waiting is not always a problem. Being
forced to stay in the loop is how you avoid cognitive decline on the
task. You still know what is going on.

Not every use case needs 32 GB, and not every use case needs four
slots. A Qwen 3.6-class Mixture of Experts with a 262k window,
split across two slots, is already one or two or three conversations
at once. Plenty of people, plenty of days, need one. Judging local
AI against the laxity of a cloud vendor who advertises a million
tokens — and whose quality, if you listen to people who actually
use Claude hard, starts falling over well before that, so they start
new sessions anyway — is a category error. Use cases have
requirements. A million-token carrot that auto-compacts and bills
you for the reprocessing is a meter, not a gift.

Setup knowledge is a barrier. llama-swap, slot counts, KV cache,
which quant fits. We are early in a boom; of course the UX is still
ugly. It will get easier. Enthusiasts will put up with the hassle.
The Windows 95 masses will not, until someone packages it. That is
fine. It does not make the underlying capability fake.

The other side of the ledger is the subscription. One year of a
heavy cloud plan is already in the neighbourhood of a mid-range
local box. Year two, year three, year four, you keep paying. Locally
you paid once, plus electricity. Models keep getting better for a
while yet, even as we are in diminishing-returns territory for any
given size: you bought the card, the card got more useful. For a
business there is also the invoice circus — another vendor, another
seat, another person whose usage you cannot predict.

I would rather have a limit on how many sessions I can run at once,
and a machine that is always there, than a weekly token pool I have
to pace. Tuesday, 75% gone, reset on Friday: slow down so you do not
run out, then scramble to burn the rest so the money was not
"wasted." That is a sunk-cost fallacy and we fall for it anyway.
Some weeks you needed more than the plan. The next tier is twice or
ten times the money. Then you are on OpenRouter or raw APIs at
unsubsidized rates, buying $50 credit packs. The baseload of real
work does not match a tiered menu.

You can still buy a cheap Qwen token plan or DeepSeek credits for
the jobs you do not mind leaving the building. Those plans are
excellent value. Use them as overflow. Keep the bulk, and anything
with a name or an invoice in it, on the box in the next room.

Transpose the current cloud deal back to 1995. Someone tells you
that a personal computer will cost the equivalent of a hundred euros
a month, and that Microsoft Word will refuse a sentence because it
breaches a safety policy, and that you may not search for a topic
because it breaches terms of service. Whose job is it to tell me
what I do with my computer? The machine, and what you type into it,
is an extension of what you have in your mind. Nobody has managed to
censor that. Vendors are reducing legal liability by putting an
imperfect classifier between your fingers and the input box. There
is no perfect classifier for human language. Sessions that stop
responding because a nanny decided you were doing "cybersecurity"
research, or something merely adjacent to a banned category, are
the point. This is not a brief for doing shady things in private. I
do not want a nanny state overhead on thinking, including boring,
legal, personal thinking.

## Why people stay in the cave

I keep meeting people who think the only way to use AI is the latest
cloud model at an immense monthly cost, even for work that last
year's weights could do. Especially for coding, there is a large
misunderstanding that the only way to get working software is
whatever frontier name is fashionable this month, and that anything
else is wasting time.

They are caught, not uniformly stupid. The mechanisms are old.

People attach their name to the latest sexiest fad — Claude Code,
the frontier model of the month — the way they attached it to a blue
bubble on a phone. They do not need the thing. The name *is* the
product. I have watched this with Microsoft, with Apple, with every
incumbent that learned to sell belonging. The cave is comfortable if
the herd is in it.

Corporates go with the obvious overpriced solution because otherwise
they look like laggards, or like they are rocking the boat. I spent
a decade watching this movie under other titles: Lean, Agile, SAFe,
"AI strategy" slide decks from a firm that will happily bill for
executive absolution. [The Incredible Story of
Deft](https://overbring.com/books/deft/) is that movie as a novel.
[Lo and Behold, X!](https://overbring.com/books/lo-and-behold-x/) is
the same movie as a decade in a kingdom. Miracle-cure frameworks.
Alluring narratives of success at organizations that do not look
like yours. Passionate experts. The current AI hype is Deft in a new
cloth.

You buy a very expensive German car and, because you paid a lot, you
convince yourself it is the pinnacle of automotive. Cloud AI has the
same Veblen structure. Twenty dollars, fifty, a hundred, two hundred
a month, and rising, for the *privilege* of sending private data to
a vendor. Cache hits, cache misses, price per million tokens of
input and output — a meter on a hose you do not own. Subscriptions
get encrusted. Usage pools shrink. Serving gets cheaper for them and
dumber for you, and you cannot choose the quant. Locally you pick
the trade-off yourself.

The rental shift is not new. Dropbox if you wanted to share files.
OneDrive hijacking the PC until it stopped feeling like *your*
computer. App stores. Ripping CDs into MP3 and FLAC, then Spotify.
Office as a subscription. Someone always limits how much you can
use, for how long, at which cost. There are usually good-enough
alternatives. People are already rebuilding popular tools with
models they run themselves. You cannot put the genie back. There are
abliterated models, uncensored models, models that will answer in
ways a corporate safety deck would call incorrect. **The cat is out
of the bag. Deal with it.**

A few entrenched companies, with captured regulators, are trying to
claim the next productivity step as theirs. They dress the grab as
safety, as national security, as "open weights are dangerous," as
"DeepSeek distilled us," as "Alibaba did this and that." Fundraising
gets sketchier as the return story gets harder. They talk as if they
have already lost the technical argument and are playing the
regulatory one. You can ban whatever you want. I have GPUs. The
weights are downloaded and backed up across three disks. Stop
releasing models, ban GPU sales, do whatever you want.

Most of the good open weights are coming from China, because China
is playing exactly to the weakness the incumbents are displaying.
Anyone who already owns compute, or is willing to buy a single 12 GB
or 16 GB card second-hand, already has their card out of the bag.

The moral hazard is the fanboy who paid for the fanciest model
telling the rest of the world that local AI cannot code, cannot
work, is a toy. Thousands of people are already doing serious work
on budget cards. If that person wants a hobby and a Veblen sticker,
that is their money. When they talk to people who have never tried a
local box, they propagate the idea that the only way to benefit from
AI is to be a digital serf. That is how you put the sheep in
someone's pen again.

## A tool is only half the story

Cloud versus local is the easy argument. Competence is the one
people skip. Give someone the best power tool in the shop: they
still have to know how to use it. A trillion-parameter frontier
model and a 35-billion Mixture of Experts on your desk fail the same
way if you do not.

A tool is only half the story. The other half is knowing how to use
it, which includes knowing its limits, being wary, and taking
personal responsibility for the results. The harness matters —
people keep rediscovering this — for how the model behaves and how
it recovers from its own stupidity. Rules you write, and rules you
have the harness distill from past sessions, change the work. I
still do not think we should anthropomorphize the thing. It is
matrix multiplications on hardware. It does not have a soul. How you
work with it still determines what you get.

If you treat it as a genie that will read your mind and turn "build
me this" into the architecture you had in your head, with clean
tests, you will be disappointed. A quadrillion-parameter model
cannot mind-read. If you do not say what you need, how you need it,
which trade-offs you already made, which constraints are real, you
are paying for a wish. On a $200 Anthropic stack that can be a
hobby, a fancy car in the driveway. Fine. It is a toy. It is not a
verdict on what the rest of us can do with a box we own.

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
regurgitated. The operator is a meat proxy. YouTube is full of this,
because it films well. You are paying dearly for world knowledge and
calling it a coding benchmark.

A collaborator, with you in the driver's seat, looks like
requirements, specification, architecture, many rounds. The model
does not read your mind. You have to know what you are asking for
well enough to notice when the answer is wrong. That is engineering,
and it is not a job title.

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

The human's job with any of these models is the job it always was.
Own the problem: if you cannot explain it so another person would
understand, the deficit is older than this technology. I said that
in 2023, when LinkedIn was wailing about a shortage of "skilled LLM
users" —
[it was not a skills shortage in GenAI](https://overbring.com/blog/2023-06-02-oh-no-we-have-no-skilled-llm-users/).
Break it into pieces: knowledge gaps, hypotheses, a spec that
constrains without encoding the answer. Rambling into a microphone
can *open* a problem; it does not replace owning it. Review: a fool
with a tool is still a fool, even if the tool is cool and makes the
vendor drool. Stay in the zone where you know enough to smell
nonsense —
[the 2×2 I still use](https://overbring.com/articles/2023-06-23-on-using-llm-to-get-things-done/).
That matrix has held up better than most of what has been written
about this since. Keep the knowledge. Institutional memory that
accumulates: how this codebase does a thing, the skill you extracted
because you did it twice, the cookbook, the ledger. You pay for that
once. Scatter, hand-off, and wishful thinking are still the three
wastes. Compaction is a hand-off you do not control.

Local models do not forgive incompetence. They expose it, because
there is no trillion-parameter world-knowledge crutch to hide
behind, which is useful. The people who get value out of this are
the people who were already trying to understand the system.

Separating "the brains" from "the hands" is a managerial fantasy. I
have never seen it produce a shared picture of the work. Meraki and
craftsmanship eat the process for breakfast; they always did.

## Who wins

Whether we let a couple of companies seize the next productivity
step is a civilizational question, and my bet is on the small ones —
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
A tutor. Clarity about what you are trying to achieve, on a machine
that belongs to you, is the part that does not expire with the
model of the month.

Personal AI as ordinary as a PC in 1996, used by people who still
know how to think: that is the better future. A fatter monthly plan
is not.
