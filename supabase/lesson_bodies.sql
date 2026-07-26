-- Draft lesson bodies (~5 minute reads). PLACEHOLDER content pending Shariah
-- board review: descriptive and educational, not a fatwa, ruling, or final
-- religious guidance. A qualified, consenting scholar reviews and replaces
-- each body before launch. The reader UI shows a draft banner above every one.
-- Idempotent: keyed by slug, safe to re-run. Apply with:
--   supabase db query --linked -f supabase/lesson_bodies.sql

alter table public.lessons
  add column if not exists body text not null default '';

update public.lessons set body = $body$## Why this matters

Putting money to work is not only a financial decision. For many people it is also a question of conscience: they want their savings to grow without taking part in activities they would not choose in the rest of their lives. This draft introduces the ideas that shape faith-conscious, or "halal," investing in plain language. It is a starting point for discussion, not a ruling.

## The core idea: share the outcome

Conventional lending charges a fixed, pre-set return on money itself, regardless of how the underlying venture performs. Faith-conscious investing takes a different starting point. Money is treated as a means to fund real economic activity, and the person who provides the capital is expected to share in the genuine outcome of that activity, whether it turns out well or badly.

In practice this means an investor is a partner in a real transaction, such as trade, leasing, or a business venture, rather than a lender collecting interest. When the venture earns a profit, the investor shares in it by an agreed ratio. When it does not, the investor carries a share of that result too. Return, in this view, has to be earned by taking real risk, not guaranteed in advance.

## Where the idea comes from

These principles are not new. They grew out of centuries of trade, in which financiers and merchants pooled capital and shared the proceeds of real caravans, workshops, and farms. The modern industry that formalised them is younger, taking shape over recent decades as institutions tried to offer everyday banking and investing that stayed within the same spirit.

That history is worth knowing because it explains the emphasis you will meet everywhere in faith-conscious finance: a preference for tangible assets, real trade, and shared outcomes over abstract charges on money. When a structure feels elaborate, it is usually because it is trying to keep a genuine transaction at its centre rather than quietly recreating a loan.

## What is generally screened out

Faith-conscious frameworks usually avoid financing or profiting from activities considered harmful. The exact list is a matter for qualified scholars, but the categories commonly discussed include interest-based lending itself, gambling, and businesses whose main activity is something the framework treats as impermissible. The point is not to chase a loophole but to keep the source of a return clean.

Screening is rarely all-or-nothing in a modern economy, where even a wholesome business may hold some cash in an interest-bearing account. Scholars therefore discuss thresholds and the idea of "purification," where any small, incidental impermissible income is calculated and given away rather than kept. The details, including any thresholds and how purification is computed, are exactly the kind of thing a Shariah board confirms.

## Risk is not optional

Because return has to be earned through real risk, faith-conscious investing does not promise fixed or guaranteed profit. A projection is an estimate based on real terms; it is not a promise. Capital can be lost. This is not a weakness of the approach but a direct consequence of it: if the outcome were guaranteed regardless of the venture, the arrangement would drift back toward the very thing it sets out to avoid.

A healthy way to hold this is to expect variation, to size each commitment so that a poor outcome would not derail your plans, and to spread capital across several ventures rather than concentrating it in one.

## How this shows up in an app

When you browse opportunities, you will see the contract type that governs each one, the sector, an indication of risk, and a projected return that is clearly labelled as a projection. Before any money is committed, you are asked to acknowledge that your capital is at risk and that returns are projected rather than guaranteed. Nothing is deployed without that explicit step.

Profit, when it arrives, is distributed from the real result of the venture and recorded on your ledger. There is no hidden interest accruing in the background, and no balance that moves without a matching, recorded transaction.

## Common questions people ask

Is a projected return the same as a promise? No. It is an estimate built from the real terms of a venture, and the actual result can be higher or lower. Does avoiding interest mean lower returns? Not necessarily; it means returns come from a different source, real activity, and therefore carry the ordinary ups and downs of that activity. Is faith-conscious investing only for one community? The mechanics, shared risk, real assets, transparency, are simply prudent finance, and many people are drawn to them for that reason alone.

## A short checklist before you commit

Ask what the money actually funds, and whether that underlying activity is something you are comfortable supporting. Ask how return is generated, and satisfy yourself that it comes from real trade or a real venture rather than a fixed charge on a loan. Read the risk indication and the projection honestly, remembering the projection is an estimate. Consider how a single commitment fits your wider plans, and whether you are spreading risk sensibly.

## Where certainty comes from

This lesson is a draft. The definitions, the screening rules, any thresholds, and the treatment of incidental income are matters for qualified scholars, and they are being reviewed for this app. Treat what you read here as an orientation to the vocabulary and the spirit of the approach, and rely on the reviewed guidance for anything you act on.$body$
where slug = 'halal-investing-basics';

update public.lessons set body = $body$## What Murabaha is

Murabaha is one of the most widely used arrangements in faith-conscious finance. In plain terms it is a cost-plus sale: an institution buys a specific asset and then sells it to a client for the original cost plus a disclosed, agreed profit, with payment usually made over time. This draft explains the mechanics descriptively; the ruling details are for qualified scholars.

The defining feature is transparency. The buyer knows exactly what the asset cost and exactly how much profit the seller is adding. There is no ambiguity dressed up as a fee, and no charge that grows the longer repayment takes.

## The steps, in order

A typical Murabaha follows a clear sequence. First, a client identifies a specific asset they need, for example equipment, inventory, or raw materials. Second, the institution actually acquires that asset and, for at least a moment, genuinely owns it. Third, the institution sells the asset to the client at cost plus the agreed profit. Fourth, the client pays the agreed total, often in instalments over a set period.

The order matters. Because the institution owns the asset before selling it, however briefly, it is taking on real ownership and the responsibilities that come with it, rather than simply lending cash against interest. Scholars pay close attention to whether that ownership is real and whether the sequence is genuinely followed, because a Murabaha that skips the ownership step is not a Murabaha at all.

## A worked example in words

Imagine a workshop needs a printing machine that costs one hundred units. Rather than borrowing one hundred units of cash and repaying more, the workshop asks a financier to buy the specific machine. The financier purchases it, takes ownership, and then sells it to the workshop for one hundred and ten units, payable over a year. The ten units are the disclosed profit on a real sale, agreed once.

Notice what does not happen in this picture. The price does not rise if the workshop pays in month eleven rather than month one; the total was fixed at the sale. The financier, for a real moment, owned a real machine and bore the risk of owning it. And the workshop knew the full cost from the first day. Those three features, a fixed price, genuine ownership, and full disclosure, are what the structure is trying to protect.

## Why the profit is not interest

At first glance a fixed profit on a deferred payment can look similar to interest, and this is a common and fair question. The distinction that scholars draw is that Murabaha profit is the margin on the sale of a real, identified asset that the seller owned and delivered, agreed once at the outset. It does not increase if the client pays late, and it is not a charge on money lent.

That last point has a practical consequence. In a genuine Murabaha, late payment does not create extra profit for the seller, because the price was fixed at the sale. Institutions handle late payment in other ways that scholars discuss carefully, precisely to avoid re-introducing a growing charge on debt.

## Common misunderstandings

One misunderstanding is that the label alone makes a transaction sound; in reality scholars examine whether ownership and delivery genuinely happened. Another is that Murabaha is a way to get cash; it is a way to acquire an asset, and forcing it to produce cash is exactly what invites problems. A third is that a fixed margin guarantees the investor a safe return; the client can still fail to pay, so capital remains at risk even in a fixed-margin structure.

## What it is good for, and what it is not

Murabaha suits situations where a specific, identifiable asset is being financed: a machine, a vehicle, a batch of goods. It is straightforward, transparent, and predictable for the client, who knows the total cost from day one.

It is less suited to situations where there is no real asset to buy, or where the aim is simply to obtain cash. Trying to force those situations into a Murabaha shape is where problems arise, and it is one reason scholars scrutinise the structure rather than the label.

## Murabaha alongside profit-sharing

Murabaha is a trade-based, fixed-margin arrangement, which makes its return relatively predictable. It sits alongside profit-and-loss-sharing arrangements, where an investor shares in the actual outcome of a venture and the return varies with performance. Neither is universally better; they serve different needs. A well-built portfolio may include both, and understanding which one governs a given opportunity helps you read its risk correctly.

## A note on this draft

This lesson describes the common structure of Murabaha for orientation. The conditions that make a particular Murabaha sound, the handling of ownership and late payment, and the specific contracts used in this app are matters for qualified scholars and are under review. Use this to understand the vocabulary, and rely on the reviewed guidance for anything you act on.$body$
where slug = 'murabaha-explained';

update public.lessons set body = $body$## Risk, honestly

Every investment carries risk. That is not a marketing caveat to be skimmed past; it is the reason an investment can earn a return at all. This lesson explains the main kinds of risk in plain terms and offers practical ways to hold them sensibly. Unlike the faith-specific lessons, this one is ordinary financial education.

The single most useful habit is to treat a projected return as an estimate, never a promise. A projection is built from real terms and reasonable assumptions, but the future does not consult your spreadsheet. Some ventures will do better than projected, some worse, and a few may return less than you put in.

## The main kinds of risk

Capital risk is the possibility of getting back less than you invested, up to and including losing the whole amount. It is the most fundamental risk and the one every other risk ultimately feeds into.

Business risk is the chance that the specific venture underperforms: a trade that does not sell as expected, a project that runs over budget, a customer that does not pay. Because faith-conscious investing ties returns to real activity, business risk is front and centre rather than hidden.

Liquidity risk is the chance that you cannot get your money out when you want it. Many real-economy investments lock capital for a set term, and trying to exit early may be impossible or costly. Money you might need soon does not belong in a long-term commitment.

Concentration risk is what happens when too much of your capital sits in one place, so a single bad outcome does the damage of several. It is one of the few risks you can reduce simply by spreading out.

Timing and cycle risk reflects that whole sectors and economies move in cycles. A venture can be well run and still be caught by a downturn in its market.

## Recovery is not a guarantee

When a venture falls behind, an honest platform will say so and pursue what is owed, crediting any recoveries as they come in. That is a real and worthwhile process, but it is not a safety net. Recovery may be partial, may take time, or may not succeed. Treat a recovery process as a genuine effort with an uncertain outcome, not as a reason to worry less.

## A simple way to think about position sizing

Position sizing is just deciding how much to put into any one thing. A practical method is to choose, before you invest, the largest loss on a single venture that you could absorb without changing your plans, and to treat that as a ceiling. If losing the whole of one commitment would force you to cancel something important, the commitment is too large, however attractive the projection.

Sizing this way has a quiet benefit: it lets you take part in ventures that carry real risk, because no single one can hurt you badly. The investor who is wiped out is rarely the one who was wrong once; it is usually the one who was too concentrated when they were wrong.

## Behaviour: the risk inside you

The largest risk in many portfolios is not in the ventures at all; it is in the person holding them. Fear sells at the bottom and greed buys at the top. A projection that looks too good is most dangerous precisely when you most want to believe it.

Guard against this with rules made in calm moments: how much goes into any one venture, how you will react to a loss, and what would genuinely change your view. Writing these down before you need them turns a hard emotional decision into a simple one you already made.

## Match risk to your horizon

Time changes how much risk you can sensibly carry. Money you will need within a year has almost no time to recover from a bad patch, so it belongs somewhere accessible and steady, not in a venture that locks capital for a term. Money you will not touch for several years can ride out the ordinary ups and downs of real activity, because it has time on its side.

A useful discipline is to sort your savings into buckets by when you will need them, and to let each bucket set its own risk. The near-term bucket stays cautious and reachable. The long-term bucket can take part in ventures with real risk and real return. Mixing the two, funding a long, illiquid commitment with money you will need next month, is one of the most common and avoidable mistakes.

## Practical ways to hold risk

Size each commitment so that a poor outcome would be disappointing but not damaging. Spread capital across several ventures, sectors, and contract types rather than concentrating it. Match the term to the money, keeping an accessible cushion for near-term needs. Read the risk indicator and the contract type on every opportunity, and let them shape how much you commit. A higher projected return usually comes with higher risk; the two travel together.

## The honest bottom line

There is no version of investing that offers real return with no risk. Anyone who suggests otherwise is either mistaken or selling something. The goal is not to avoid risk, which would mean avoiding return, but to understand it, size it, spread it, and carry it with your eyes open.$body$
where slug = 'understanding-risk';

update public.lessons set body = $body$## What Zakat is

Zakat is one of the most important acts of giving in Islam: an annual share of certain qualifying wealth, given to those entitled to receive it. This draft introduces the ideas at a high level so you can follow the vocabulary. The rates, thresholds, categories, and rulings are matters for qualified scholars, and they are being reviewed for this app rather than asserted here.

The spirit that scholars describe is that wealth is a trust, and that giving a defined share purifies what remains and circulates it toward those in need. It is a duty of the wealth, tied to ownership and to the passage of time, not a voluntary donation.

## The pieces that usually come up

Discussions of Zakat commonly involve a few recurring ideas. There is a minimum threshold, often referred to by a traditional term, below which Zakat is generally not due. There is a holding period, so that Zakat applies to wealth held across a full cycle rather than money that merely passed through your hands. And there is a rate applied to the qualifying amount.

The exact threshold, how it is measured against a real benchmark, the length and treatment of the holding period, and the rate are precisely the details a Shariah board confirms. This draft deliberately does not state numbers, because stating them as settled would overstep what a placeholder should do.

## Why investments make it more involved

Zakat on simple savings is relatively easy to picture. Investments add questions, because what you own is not always straightforward cash. Scholars discuss how to treat different holdings: money committed to a venture, an ownership share in a business, assets held for trade, and profit that has been distributed to you versus capital still deployed.

Different kinds of holdings may be treated differently, and the treatment can depend on your intention and on the nature of the underlying assets. This is genuinely a specialist area, and reasonable, qualified scholars discuss the details carefully. It is one of the clearest cases where you should rely on reviewed guidance rather than a rule of thumb.

## A worked way to keep records

You do not need to master the rulings to prepare well; you need good records. A simple habit is to keep a running note, updated whenever something changes, of what you hold, when you acquired it, what has been distributed to you, and what remains committed. If you do this through the year, the eventual calculation becomes a matter of reading your own notes rather than reconstructing a year from memory.

It also helps to mark a fixed date each year as your Zakat day, so the "full cycle" has a clear anchor. Many people choose a date that is easy to remember. On that day you look at your qualifying wealth, apply the reviewed calculation, and give. Consistency of date matters more than choosing a perfect one.

## How an app can help without overstepping

A well-built app can help you gather the information a Zakat calculation needs: what you hold, how long you have held it, what has been distributed, and what remains deployed. It can present a clear, transparent working once the reviewed rules are in place, and it can point any incidental impermissible income toward purification separately from Zakat.

What a responsible app will not do is invent a threshold or a rate, or present an unreviewed figure as if it were settled. Where a live benchmark is needed and not yet connected, the honest answer is to say so rather than to estimate. You may see exactly that: a status shown as unavailable rather than a made-up number.

## Common questions

Is Zakat the same as ordinary charity? No; scholars describe it as a defined duty of qualifying wealth, distinct from voluntary giving, though both are encouraged. Do I owe Zakat on money that is locked in a venture? That is one of the questions the reviewed guidance answers, and it may depend on the nature of the holding. Should I wait until I am certain before giving anything? Keeping good records and asking a qualified scholar is better than either guessing or delaying indefinitely.

## A gentle way to approach it

Keep simple records through the year. Separate the question of Zakat from the separate practice of giving away any small incidental impermissible income, since they are different things with different purposes. When the time comes, use the reviewed calculation and, where your situation is unusual, ask a qualified scholar directly. Zakat rewards care and honesty far more than speed.

## About this draft

Everything above is orientation, not a ruling. No threshold, rate, or category here should be treated as final. The Zakat guidance for this app, including the standard used for the threshold and the treatment of each kind of investment, is under review by qualified scholars and will replace this placeholder before launch.$body$
where slug = 'zakat-on-investments';

select slug, title, length(body) as body_chars from public.lessons order by sort;
