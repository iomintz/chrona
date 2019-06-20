CREATE TABLE expiries(
	guild_id BIGINT NOT NULL,
	channel_id BIGINT PRIMARY KEY,
	expiry INTERVAL NOT NULL,

	UNIQUE (guild_id, channel_id));

CREATE TABLE timers(
	timer_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	created TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	expires TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	event TEXT NOT NULL,
	payload jsonb NOT NULL DEFAULT '{}'::jsonb);

CREATE INDEX "timers_expires_idx" ON timers (expires);
CREATE INDEX "timers_payload_kwargs_message_id_idx" ON timers USING GIN ((payload -> 'kwargs' -> 'message_id'));
