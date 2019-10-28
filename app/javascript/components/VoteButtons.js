import React from "react";
import PropTypes from "prop-types";

import VoteButton from "./VoteButton.js";

class VoteButtons extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      isUpvoted: this.props.isUpvoted,
      isDownvoted: this.props.isDownvoted,
      upvotes: this.props.upvotes,
      downvotes: this.props.downvotes,
    };
    this.upvote = this.upvote.bind(this);
    this.downvote = this.downvote.bind(this);

    const token = document.querySelector('meta[name="csrf-token"]').content;
    this.headers = { 'X-CSRF-Token': token };
  }

  render () {
    return (
      <React.Fragment>
        <VoteButton
          className={this.state.isUpvoted ? "upvote-button upvoted" : "upvote-button"}
          callback={this.upvote}
          value="↑"
        />
        <div>
          {this.state.upvotes - this.state.downvotes}
        </div>
        <VoteButton
          className={this.state.isDownvoted ? "downvote-button downvoted" : "downvote-button"}
          callback={this.downvote}
          value="↓"
        />
      </React.Fragment>
    );
  }

  upvote() {
    // Make request, then style
    fetch(this.props.upvotePath, {
      method: 'POST',
      headers: this.headers,
    }).then((response) => {
      if (!response.ok) {
        return console.error(response);
      }

      // Should we retrieve the new vote counts from the backend?
      const upvotes = this.state.isUpvoted ? this.state.upvotes - 1 : this.state.upvotes + 1;
      const downvotes = this.state.isDownvoted ? this.state.downvotes - 1 : this.state.downvotes;
      this.setState({
        isUpvoted: !this.state.isUpvoted,
        isDownvoted: false,
        upvotes,
        downvotes,
      });
    });
  }

  downvote() {
    // Make request, then style
    fetch(this.props.downvotePath, {
      method: 'POST',
      headers: this.headers,
    }).then((response) => {
      if (!response.ok) {
        return console.error(response);
      }

      const upvotes = this.state.isUpvoted ? this.state.upvotes - 1 : this.state.upvotes;
      const downvotes = this.state.isDownvoted ? this.state.downvotes - 1 : this.state.downvotes + 1;
      this.setState({
        isUpvoted: false,
        isDownvoted: !this.state.isDownvoted,
        upvotes,
        downvotes,
      });
    });
  }
}

VoteButtons.propTypes = {
  upvotes: PropTypes.number,
  downvotes: PropTypes.number,
  isUpvoted: PropTypes.bool,
  isDownvoted: PropTypes.bool,
  upvotePath: PropTypes.string,
  downvotePath: PropTypes.string,
};

export default VoteButtons;
